# Basic shift scheduler API
This is an attempt to complete [Soho House Reception Scheduler](https://github.com/SohoHouse/reception-scheduler) challenge.
Project setup and implementation is done within the 2 hour time limit.


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
