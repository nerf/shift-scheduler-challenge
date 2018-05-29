# Basic shift scheduler
*Not complete/WIP*

## What is done

 - Project setup

    - rspec, activerecord, etc...

 - Basic shift scheduler
 - Baisc API

## How to use
```
# Clone the project
cd project_dir
bundle
rackup
```

## Examples

##### Create house

```
curl -X "POST" "http://localhost:9292/houses" \
     -H 'Content-Type: application/x-www-form-urlencoded; charset=utf-8' \
     --data-urlencode "name=FooBar" \
     --data-urlencode "address=London"
```

##### List houses

`curl -X "GET" "http://localhost:9292/houses"`

##### Create Employee

```
curl -X "POST" "http://localhost:9292/employees" \
     -H 'Content-Type: application/x-www-form-urlencoded; charset=utf-8' \
     --data-urlencode "name=Joe Doe" \
     --data-urlencode "house_id=1"

```

##### List Employees

`curl -X "GET" "http://localhost:9292/employees"`

##### Create shift

```
curl -X "POST" "http://localhost:9292/shifts" \
     -H 'Content-Type: application/x-www-form-urlencoded; charset=utf-8' \
     --data-urlencode "employee_id=1" \
     --data-urlencode "house_id=1" \
     --data-urlencode "to=2018-05-29T19:56:42+00:00" \
     --data-urlencode "from=2018-05-29T18:56:42+00:00"
```

##### List shifts

`curl -X "GET" "http://localhost:9292/shifts/1"`

**ID of the house**


## Notes

 - I made bad decisions from the start to setup everything from scratch.
 - For me the four hours limit is not enough to cover all edge cases. I managed to handle some but many are still present.
 - Didn't had time to review my code.. expect many typos,bad names, etc..
 - The API is pretty limited. Didn't had time to do more.
 - There is no UI
