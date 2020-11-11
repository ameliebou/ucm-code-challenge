# UCM code challenge

This is my proposal to the code challenge supplied by UCM agency.
[Here](https://docs.google.com/document/d/11HfJX4YIzdb7UY5oDgi8toa4JObmtuNPNojY8vnEDAM/view) you can find the whole description of the challenge.
In summary, I have created an API where:
* Users can register
* Jobs can be created and searched for
* Users can apply to jobs

## Table of content
* [Technologies](#technologies)
* [Setup](#setup)
* [Tests](#test)
* [API](#api)
...* [Users](#users)
...* [Jobs](#jobs)
...* [Assignments](#assignments)

## Technologies
* Ruby 2.6.6
* Rails 5.2.4.4

## Setup
```
$ git clone https://github.com/ameliebou/ucm-code-challenge
$ cd ucm-code-challenge
$ bundle install
```

## Tests
You can run the test suite by running the following command
`bundle exec rspec`

You can also use the following commands for more precision
```ruby
# Run the models tests
bundle exec rspec spec/models

# Run the requests tests
bundle exec rspec spec/requests

# Run the controllers tests
bundle exec rspec spec/controllers
```

## API

### Users

**Sign up**

`POST /api/v1/sign_up`

Users that want to sign up will need to use a unique email address.

Parameters:
| Name                     | Type            | Description                        |
| ------------------------ | --------------- | ---------------------------------- |
| `email`                  | string          | Email of the user                  |
| `password`               | string          | Password                           |
| `password_confirmation`  | string          | Password confirmation              |

Example:
```
{
  "email": "test@test.com",
  "password": "123456",
  "password_confirmation": "123456"
}
```

**Sign in**

`POST /api/v1/sign_in`

Parameters:
| Name                     | Type            | Description                        |
| ------------------------ | --------------- | ---------------------------------- |
| `email`                  | string          | Email of the user                  |
| `password`               | string          | Password                           |

Example:
```
{
  "email": "test@test.com",
  "password": "123456"
}
```

### Jobs
**Get all the jobs available on the API**

`GET /api/v1/jobs`

The response is a json with the following keys: `id`, `title`, `total_pay` and `spoken_languages`.

Pagination has been implemented with a limit of 20 results. In order to get access to further jobs or to narrow down the number of jobs shown, two parameters can be used: `limit` and `offset`.

Parameters:
| Name             | Type                        | Description                        |
| ---------------- | --------------------------- | ---------------------------------- |
| `limit`          | string                      | Number of jobs displayed (max: 20) |
| `offset`         | string                      | Offset of jobs                     |


Example:
```
{
  "limit": 20,
  "offset": 20
}
```

**Search jobs by title and/or by language**

`GET /api/v1/jobs`

Parameters:
| Name               | Type                        | Description                        |
| ------------------ | --------------------------- | ---------------------------------- |
| `title`            | string                      | Title of the job searched for      |
| `spoken_language`  | string                      | Language of the job searched for   |

Example:
```
{
  "title": 'kitchen',
  "spoken_language": 'german'
}
```

**Create a new job**

`POST /api/v1/jobs`

Parameters:
| Name               | Type                        | Description                        |
| ------------------ | --------------------------- | ---------------------------------- |
| `title`            | string                      | The title of the job               |
| `salary_per_hour`  | number                      | The pay per hour                   |
| `spoken_languages` | array of strings            | The languages required for the job |
| `shifts`           | array of arrays             | The shift dates for the job        |

The parameter `spoken_languages` is an array containing the different languages required for the job as strings. *A job must have at least one spoken language.*

The parameter `shifts` is an array of arrays. Each subarray needs two strings: the first string is the starting date and time of the shift, the second string is the ending date and time. *A job must have between one and seven shift(s).*

Example:
```
{
  "title": "Promoter",
  "salary_per_hour": 18.5,
  "spoken_languages": [ "english", "german" ],
  "shifts": [["15-11-2020, 11:00+1", "15-11-2020, 15:00+1"]]
}
```

### Assignments

`POST /api/v1/jobs/:job_id/assignments`

Parameters:
| Name               | Type                        | Description                        |
| ------------------ | --------------------------- | ---------------------------------- |
| `user_email`       | string                      | Email of the user                  |
| `user_token`       | string                      | Authentication token of the user   |

Example:
```
{
  "user_email": "emma@example.com",
  "user_token": "KJjLa3sGNzbJV575gowK"
}
```
