## Install

### Clone the repository

```bash
git clone https://github.com/shahnawaz-ror/test_task.git
cd test_task

```

### Check your Ruby version

```bash
ruby -v
```

The ouput should start with something like `ruby 2.7.5`

If not, install the right ruby version using rvm (it could take a while):

```bash
rvm install "ruby-2.7.5"
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler):

```bash
bundle
```

### Update database.yml file
In database.yml file, edit the database configuration as required.

### Initialize the database

```ruby
rails db:create db:migrate db:seed
```

### Serve

```ruby
rails s
```
And now you can visit the site with the URL http://localhost:3000

### Additonal Info
run below command 

```bash
rspec
```
