# Scraping Facebook groups

Facebook groups provide a rich dataset of discussions. This script seeks to scrape these into a simple CSV for further analysis.

## Prerequisites

This script assumes that you have a Facebook account and that you've linked it to a Facebook For Developers account. [Click here](https://developers.facebook.com) to log into your developer account. You will need to use this developer account to get a [user token](https://developers.facebook.com/tools/explorer/) capable of accessing `user_managed_groups`. You will also need your group's ID number, which can be found in its URL.

## Data dictionary

This script outputs a CSV with seven columns:

* **from_id**: The user ID of the individual who made the post or comment
* **from_name**: The full name of the individual who made the post or comment
* **id**: The ID of the post or the post in response to which the comment was made
* **message**: The text of the post or comment
* **link**: The link (if any) associated with the post; comments do not have links associated with them and will always read `NA`
* **created_time**: The time at which the post or comment was submitted
* **likes_count**: The number of likes received by the post or comment
* **is_comment**: `TRUE` if the entry is a comment, `FALSE` if it is a post

## Built With

[Rfacebook](http://pablobarbera.com/blog/archives/3.html) - Easy R interface for Facebook

## Authors

* **Nathaniel Hendrix** - [My Website](https://nathanielhendrix.com)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
