erl_wurfl_cloud
===============

A WURFL cloud client written in Erlang.

This client enables to get WURFL device capabilities given a user agent,
very useful to adapt HTML pages to the handset.

This client requires to create a WURFL cloud client account here:
https://www.scientiamobile.com/cloud

Using this client, you can only request device capabilities set in your 
account settings on scientiamobile.com

This is a very basic client which doesn't include any cache.
The API merely returns the raw JSON replied by the WURFL cloud server.

## Getting started ##

Clone the repository and download rebar.

```
git clone https://github.com/ntalfer/erl_wurfl_cloud.git
cd erl_wurfl_cloud
wget http://cloud.github.com/downloads/basho/rebar/rebar && chmod u+x rebar
```

Get your API key in your account settings on scientiamobile.com and set it
as an OS environment variable.

```
export WURFL_API_KEY=<Your WURFL API Key>
```

Compile


```
./rebar compile
```

Launch erlang vm and start playing !


```
erl -pa ebin
```

...and start playing !

In the example below, we have a user agent (UA) for which we request 5 capabilities.

Erlang R15B03 (erts-5.9.3.1) [source] [smp:4:4] [async-threads:0] [kernel-poll:false]

```
Eshell V5.9.3.1  (abort with ^G)
1> application:start(inets).
ok
2> UA = "Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3".
"Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3"
3> wurfl_cloud_client:get_device(UA, ["model_name", "release_date", "resolution_width", "resolution_height", "dual_orientation"]).
{ok,"{\"apiVersion\":\"WurflCloud 1.5.0.2\",\"mtime\":1407812091,\"id\":\"apple_iphone_ver5\",\"capabilities\":{\"model_name\":\"iPhone\",\"release_date\":\"2011_october\",\"resolution_width\":320,\"resolution_height\":480,\"dual_orientation\":true},\"errors\":{}}"}
4> 
```
