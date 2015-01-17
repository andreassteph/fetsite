#! /bin/bash
ruby_command="ruby"
rake_command="rake"
bundler_command="bundler"

# Are the necessary programs installed?
command -v $ruby_command >/dev/null 2>&1 || { echo >&2 "The given ruby command does not exist. Please change the command or install ruby"; exit 1; }
command -v $rake_command >/dev/null 2>&1 || { echo >&2 "The given rake command does not exist. Please change the command or install ruby"; exit 1; }
command -v $bundler_command >/dev/null 2>&1 || { echo >&2 "The given bundler command does not exist. Please change the command or install ruby"; exit 1; }

echo "All necessary programs exist"

echo "Generating base configs..."
# Generate clean config files if they don't exist
cp -u config/database.yml.example config/database.yml
cp -u config/omniauth_secrets.yml.example config/omniauth_secrets.yml

echo "Bundle install..."
# Run Bundler
$bundler_command install || {echo "Bundler failed. Please run \"$bundle\_command install\" seperately and debug the errors, before running this script again";exit 1;}

echo "Migrate the database..."
# Run the migration
$rake_command db:migrate ||{echo "Migration failed. Please run \"$rake\_command db:migrate\" seperately and debug the errors, before running this script again"; exit 1;}

echo "Start the sunspot server"
# Run Sunspot
$rake_command sunspot:solr:stop &> /dev/null
$rake_command sunspot:solr:start || exit 1

# Topic 1 is supposed to be the startpage topic
if [ ! -f config/start_topic.yml ]; then
    echo "generate new start_topic with topic id 1"
    echo "1" > config/start_topic.yml
fi

# Generate fetadmin user "admin@fet.at", password: 12345678



echo "The homepage is ready to use."
echo "A dummy admin user has been created. The credentials are:"
echo ""
echo "  email: admin@fet.at"
echo "  password: 12345678"
echo ""
echo "Please delete this user after a proper setup"
echo ""
echo "The Rails server is started with the command \"rails server\""
echo "The Rails console is started with the command \"rails console\""

