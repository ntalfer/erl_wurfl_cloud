-module(wurfl_cloud_client).

%% API
-export([get_device/1, get_device/2]).

-define(api_version, "v1").
-define(api_server, "api.wurflcloud.com").
-define(http_timeout, 1000).
-define(client_version, "WurflCloud_Client/Erlang_0.1.0").

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Get all capabilities available for a device given its user agent
%% Only 
%%
%% @spec get_device(string()) -> {ok, JSON} | {error, Error}
%% @end
%%--------------------------------------------------------------------
get_device(User_agent) ->
    get_device(User_agent, []).

%%--------------------------------------------------------------------
%% @doc
%% Get a list of capabilities available for a device given its user 
%% agent. Go to https://www.scientiamobile.com/wurflCapability to get
%% the list of available capabilities.
%%
%% @spec get_device(string(), [string()]) -> {ok, JSON} | {error, Error}
%% @end
%%--------------------------------------------------------------------
get_device(User_agent, Capabilities) ->
    case os:getenv("WURFL_API_KEY") of
	false ->
	    {error, "Please set WURFL_API_KEY os environment variable."};
	API_key ->
	    get_device(API_key, User_agent, Capabilities)
    end.

%%%===================================================================
%%% Internal
%%%===================================================================
get_device(API_key, User_agent, Capabilities) ->    
    Path = get_path(Capabilities),
    Headers = [{"Authorization", "Basic " ++ base64:encode_to_string(API_key)},
	       {"User-Agent", User_agent},
	       {"X-Cloud-Client", ?client_version}],
    URL = "http://" ++ ?api_server ++ Path,
    HTTPOptions = [{timeout, ?http_timeout}],
    Options = [],
    case httpc:request(get, {URL, Headers}, HTTPOptions, Options) of	
	{ok, {{_, 200, _}, _, Body}} ->
	    {ok, Body};
	{ok, {{_, Code, _}, _, Body}} ->
	    {error, {Code, Body}};
	Error ->
	    Error
    end.

get_path(Capabilities) ->
    V = "/" ++ ?api_version,
    case Capabilities of
	[] -> V ++ "/json";
	_  -> V ++ "/json/search:(" ++ string:join(Capabilities, ",") ++ ")"
    end.
