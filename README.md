# UCM code challenge

This is my proposal to the code challenge supplied by UCM agency.
[Here](https://docs.google.com/document/d/11HfJX4YIzdb7UY5oDgi8toa4JObmtuNPNojY8vnEDAM/view) you can find the whole description of the challenge.
In summary, I have created an API where:
* users can register
* jobs can be created and searched for
* users can apply to jobs

## Table of content
* [Technologies](#technologies)
* [Setup](#setup)
* [Tests](#test)
* [API](#api)

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
  limit: 20,
  offset: 20
}
```

**Search jobs by title and/or by language**

Parameters:
| Name               | Type                        | Description                        |
| ------------------ | --------------------------- | ---------------------------------- |
| `title`            | string                      | Title of the job searched for      |
| `spoken_language`  | string                      | Language of the job searched for   |

Example:
```
{
  title: 'kitchen',
  spoken_language: 'german'
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
| `shifts`           | array of arrays of DateTime | The shift dates for the job        |

Example:
```
{
  "title": "Promoter",
  "salary_per_hour": 18.5,
  "spoken_languages": [ "english", "german" ],
  "shifts": [["2020-11-11T13:00:00+01:00", "2020-11-11T16:00:00+01:00"]]
}
```

### Assignments
