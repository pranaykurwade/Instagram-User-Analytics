
# A) Marketing Analysis:
# 1. Loyal User Reward: The marketing team wants to reward the most loyal users, i.e., those who have been using the platform for the longest time.
# Your Task: Identify the five oldest users on Instagram from the provided database.

select * from users
order by created_at limit 5 ;

# 2. Inactive User Engagement: The team wants to encourage inactive users to start posting by sending them promotional emails.
# Your Task: Identify users who have never posted a single photo on Instagram.

select username from users
left join photos
on users.id = photos.user_id
where photos.id is null;

# 3. Contest Winner Declaration: The team has organized a contest where the user with the most likes on a single photo wins.
# Your Task: Determine the winner of the contest and provide their details to the team.

select username, photos.id, photos.image_url, count(likes.user_id)as most_likes
from photos
inner join likes
on likes.photo_id = photos.id
inner join users
on users.id = photos.user_id
group by photos.id
order by most_likes DESC limit 1;

# 4. Hashtag Research: A partner brand wants to know the most popular hashtags to use in their posts to reach the most people.
# Your Task: Identify and suggest the top five most commonly used hashtags on the platform.

select tags.tag_name, count(*) as most_use_tag
from photo_tags
join tags
on photo_tags.tag_id = tags.id
group by tags.id
order by most_use_tag desc limit 5 ;

# 5. Ad Campaign Launch: The team wants to know the best day of the week to launch ads.
# Your Task: Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign.

select dayname(created_at) as day, count(*) as most_users_register_on_day
from users
group by day
order by most_users_register_on_day desc;


B) Investor Metrics:
# 1. User Engagement: Investors want to know if users are still active and posting on Instagram or if they are making fewer posts.
# Your Task: Calculate the average number of posts per user on Instagram. Also, provide the total number of photos on Instagram divided by the total number of users.

select (select count(*) from photos) / (select count(*) from users) as avg_number_of_post_per_user;


# 2. Bots & Fake Accounts: Investors want to know if the platform is crowded with fake and dummy accounts.
# Task: Identify users (potential bots) who have liked every single photo on the site, as this is not typically possible for a normal user.


select user_id, count(*) as number_of_likes
from likes
group by user_id
having number_of_likes = (select count(*) from photos) ;
select u.username, count(*) as number_of_likes
from users u
join likes
on u.id = likes.user_id
group by u.id
having number_of_likes = (select count(*) from photos);
