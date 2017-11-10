## This package scrapes an example facebook group. 
## It was written by Nathaniel Hendrix, www.nathanielhendrix.com

if (!require(Rfacebook)) install.packages('Rfacebook')
if (!require(Rook)) install.packages('Rook')
if (!require(dplyr)) install.packages('dplyr')

library(Rfacebook)
library(Rook)
library(dplyr)

# Set working directory
setwd("*** Your working directory here ***")

# Get a temporary user token from https://developers.facebook.com/tools/explorer/
# Make sure to select user_managed_groups when requesting your token
# This token will only last ~ 2 hours before you need to request a new one
token <- "*** Your token here ***"

# Request the first 2000 posts and comments of group page :
# Note, you can only scrape a group page if it is a public group or if you are an admin
page <- getPage("*** Your group ID here ***",      # change to the group ID 
                token,
                n = 2000,              # change this if you need more than 20k
                feed = TRUE,
                since = "2015-11-12",   # year / month / date 
                until = "2017-11-12")   # if you want up to date, set this to one day in the future because it's GST

# Select items of interest
#
# Note: events and other non-text posts will show up as <NA>
# These items will be kept and mined for comments
posts <- page %>%
  select(from_id, from_name, id, message, link, created_time, likes_count)

# get comments on posts
comments <- data.frame(from_id      = character(0),
                       from_name    = character(0),
                       id           = character(0),
                       message      = character(0),
                       created_time = character(0),
                       likes_count  = numeric(0))
for(i in 1:nrow(posts)){
  temp <- getPost(posts[i,3], token)
  if(nrow(temp$comments) > 0){
    temp$comments$id <- posts[i,3]
    temp$comments$link <- NA
    comments <- rbind(comments, temp$comments)
  }
}

# combines posts and comments
comments$is_comment <- TRUE
posts$is_comment <- FALSE
combined <- rbind(posts, comments)

# sorts by post id
combined <- combined[order(combined$id),]

# writes sorted posts and comments to csv
write.csv(combined, "fb_scrape.csv", row.names = FALSE)
