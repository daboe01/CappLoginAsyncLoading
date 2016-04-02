#!/usr/local/ActivePerl-5.14/site/bin/morbo

use Apache::Session::File;
use Mojolicious::Lite;
use Mojo::JSON qw(decode_json encode_json);
use Net::LDAP;
use Data::Dumper;


# enable receiving uploads up to 1GB
$ENV{MOJO_MAX_MESSAGE_SIZE} = 1_073_741_824;

plugin 'database', { 
            dsn      => 'dbi:Pg:dbname=aug_clinical;user=root;host=localhost',
            username => 'root',
            password => 'root',
            options  => { 'pg_enable_utf8' => 1, AutoCommit => 1 },
            helper   => 'db'
};

helper LDAPChallenge => sub { my ($self, $name, $password)=@_;
return 1;
    my $ldap = Net::LDAP->new( 'ldap://ldap.ukl.uni-freiburg.de' );
    my $msg = $ldap->bind( 'uid='.$name.', ou=people, dc=ukl, dc=uni-freiburg, dc=de', password => $password);
    return $msg->code==0;
};
        
get '/AUTH' => sub {
    my $self=shift;
    my $user= $self->param('u');
    my $pass= $self->param('p');
    my $sessionid='';
    if(0&& $user)
    {   if($self->LDAPChallenge($user,$pass))
        {   my  %session;
            tie %session, 'Apache::Session::File', undef , {Transaction => 0};
            $sessionid = $session{_session_id};
            $session{username}=$user;
        }
    } $self->render(text => $sessionid );
};
                
###################################################################
# main()


app->config(hypnotoad => {listen => ['http://*:3004'], workers => 10, proxy => 1, heartbeat_timeout=>1200, inactivity_timeout=> 1200});
app->start;
