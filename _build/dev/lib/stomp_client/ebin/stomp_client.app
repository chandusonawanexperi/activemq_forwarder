{application,stomp_client,
             [{config_mtime,1733335524},
              {optional_applications,[]},
              {applications,[kernel,stdlib,elixir,logger]},
              {description,"STOMP client for Elixir with broker specific addons"},
              {modules,['Elixir.StompClient',
                        'Elixir.StompClient.DefaultCallbackHandler',
                        'Elixir.StompClient.Parser',
                        'Elixir.StompClient.RabbitMQ.PersistedPubSub',
                        'Elixir.StompClient.RabbitMQ.PersistedWorkQueue',
                        'Elixir.StompClient.State']},
              {registered,[]},
              {vsn,"0.1.1"}]}.