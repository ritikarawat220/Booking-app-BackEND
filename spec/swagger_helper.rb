# We have to disable this linters check to enable api doc creation
# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.configure do |config|
  # Your code here

  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1',
        description: 'API documentation for making aeroplane reservations for purchases'
      },
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'http://127.0.0.1:4000'
            }
          }
        }
      ],
      paths: {
        '/current_user': {
          get: {
            summary: 'Get current user',
            tags: [
              'CurrentUser'
            ],
            description: 'Returns details of the current user',
            responses: {
              '200': {
                description: 'Operation successful',
                content: {
                  'application/json': {
                    schema: {
                      type: 'array',
                      items: {
                        type: 'object',
                        properties: {
                          id: { type: 'integer' },
                          name: { type: 'string' },
                          email: { type: 'string' }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        },

        '/signup': {
          post: {
            summary: 'Create/Signup a new user',
            tags: ['CurrentUser'],
            description: 'Creates new user with the provided data',
            requestBody: {
              required: true,
              content: {
                'application/json': {
                  schema: {
                    type: 'object',
                    properties: {
                      name: {
                        type: 'string'
                      },
                      email: {
                        type: 'string',
                        format: 'email'
                      },
                      password: {
                        type: 'string',
                        format: 'password'
                      },
                      password_confirmation: {
                        type: 'string',
                        format: 'password'
                      }
                    }
                  }
                }
              }
            },
            responses: {
              '201': {
                description: 'Signed up successfully.',
                content: {
                  'application/json': {
                    schema: {
                      type: 'object',
                      items: {
                        type: 'object',
                        properties: {
                          id: { type: 'integer' },
                          name: { type: 'string' },
                          email: { type: 'string' }
                        }
                      }
                    }
                  }
                }
              },
              '400': {
                description: 'Bad request',
                content: {
                  'application/json': {
                    schema: {
                      type: 'array',
                      items: {
                        type: 'object',
                        properties: {
                          error_message: {
                            type: 'string',
                            description: "User couldn't be created successfully."
                          }
                        }
                      }
                    }
                  }
                }
              }
            }

          }
        },
        '/login': {
          post: {
            summary: 'log into the app',
            tags: ['CurrentUser'],
            description: 'Log into the app using a bearer token from devise-jwt',
            requestBody: {
              required: true,
              content: {
                'application/json': {
                  schema: {
                    type: 'object',
                    properties: {
                      email: {
                        type: 'string',
                        format: 'email'
                      },
                      password: {
                        type: 'string',
                        format: 'password'
                      }
                    }
                  }
                }
              }
            },
            responses: {
              '200': {
                description: 'Logged in successfully.',
                content: {
                  'application/json': {
                    schema: {
                      type: 'object',
                      items: {
                        type: 'object',
                        properties: {
                          id: { type: 'integer' },
                          name: { type: 'string' },
                          email: { type: 'string' }
                        }
                      }
                    }
                  }
                }
              },
              '401': {
                description: 'Unauthorized or Bad request',
                content: {
                  'application/json': {
                    schema: {
                      type: 'array',
                      items: {
                        type: 'object',
                        properties: {
                          error_message: {
                            type: 'string',
                            description: 'Incorrect email or password. Please try again!'
                          }
                        }
                      }
                    }
                  }
                }
              },
              '403': {
                description: 'Invalid or missing bearer token. Login again using a valid token from devise-jwt.',
                content: {
                  'application/json': {
                    schema: {
                      type: 'object',
                      properties: {
                        error_message: {
                          type: 'string',
                          description: 'Invalid or missing bearer token. login using a valid token from devise-jwt.'
                        }
                      }
                    }
                  }
                }
              }
            },
            security: {
              BearerAuth: []
            },
            securityScheme: {
              BearerAuth: {
                type: 'http',
                scheme: 'bearer',
                bearerFormat: 'JWT'
              }
            }

          }

        },
        '/logout': {
          delete: 'Logout user',
          tags: [
            'CurrentUser'
          ]
        },
        '/aeroplanes': {
          get: {
            summary: 'Get all aeroplanes',
            tags: [
              'Aeroplanes'
            ],
            description: 'Shows all the doctors',
            responses: {
              '200': {
                description: 'success',
                content: {
                  'application/json': {
                    schema: {
                      type: 'array',
                      items: {
                        type: 'object',
                        properties: {
                          id: { type: 'number' },
                          name: { type: 'string' },
                          model: { type: 'string' },
                          description: { string: 'string' },
                          price: {
                            type: 'number',
                            format: 'float'
                          },
                          booking_price: {
                            type: 'number',
                            format: 'float'
                          },
                          image: { type: 'string' }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        },
        '/aeroplanes/{:id}': {
          get: {
            summary: 'Get a selected aeroplane',
            tags: ['Aeroplane'],
            description: 'Retrieves a selected aeroplane',
            parameters: [
              {
                name: 'id',
                in: 'path',
                required: true,
                description: 'Aeroplane ID',
                schema: {
                  type: 'integer'
                }
              }
            ],
            responses: {
              '200': {
                description: 'successful operation',
                content: {
                  'application/json': {
                    schema: {
                      type: 'array',
                      items: {
                        type: 'object',
                        properties: {
                          id: { type: 'number' },
                          name: { type: 'string' },
                          model: { type: 'string' },
                          description: { string: 'string' },
                          price: {
                            type: 'number',
                            format: 'float'
                          },
                          booking_price: {
                            type: 'number',
                            format: 'float'
                          },
                          image: { type: 'string' }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        },
        '/aeroplanes/create': {
          post: {
            summary: 'Create an aeroplane status',
            tags: ['Aeroplanes'],
            description: 'Creates a new aeroplane status with provided data',
            requestBody: {
              required: true,
              content: {
                'application/json': {
                  schema: {
                    type: 'object',
                    properties: {
                      name: { type: 'string' },
                      model: { type: 'string' },
                      description: { string: 'string' },
                      price: { type: 'number' },
                      booking_price: { type: 'number' },
                      image: { type: 'string' }
                    }
                  }
                }
              }
            },
            responses: {
              '201': {
                description: 'Aeroplane created successfully',
                content: {
                  'application/json': {
                    schema: {
                      type: 'object',
                      items: {
                        type: 'object',
                        properties: {
                          id: { type: 'integer' },
                          name: { type: 'string' },
                          model: { type: 'string' },
                          description: { string: 'string' },
                          price: { type: 'number' },
                          booking_price: { type: 'number' },
                          image: { type: 'string' }
                        }
                      }
                    }
                  }
                }
              },
              '400': {
                description: 'Bad request invalid data',
                content: {
                  'application/json': {
                    schema: {
                      type: 'object',
                      properties: {
                        error: {
                          type: 'string'
                        }
                      }
                    }
                  }
                }
              }
            }

          }
        },
        '/aeroplanes/{aeroplane_id}': {
          delete: {
            summary: 'Delete an aeroplane by id',
            tags: ['Aeroplanes'],
            description: 'Deletes a given aeroplane',
            parameters: [
              {
                name: 'aeroplane_id',
                in: 'path',
                required: true,
                description: 'Aeroplane ID',
                schema: {
                  type: 'integer'
                }
              }
            ],
            responses: {
              '204': {
                description: 'Aeroplane successfully deleted'
              }
            }
          }
        },
        '/aeroplanes/:aeroplane_id/reservations/create': {
          post: {
            summary: 'Creates a specific aeroplane purchase reservation',
            tags: ['Reservations'],
            description: 'Creates a booking?reservation for a specifi aeroplane',
            parameters: [
              name: 'id',
              in: 'path',
              required: true,
              description: 'Aeroplane ID',
              schema: {
                type: 'integer'
              }
            ],
            requestBody: {
              required: true,
              content: {
                'application/json': {
                  schema: {
                    type: 'object',
                    properties: {
                      reservation_date: { format: 'date' },
                      returning_date: { format: 'date' },
                      city: { type: 'string' }
                    }
                  }
                }

              }
            },
            responses: {
              '201': {
                'application/json': {
                  description: 'Created successfully',
                  content: {
                    schema: {
                      type: 'array',
                      items: {
                        type: 'object',
                        properties: {
                          reservation_date: { type: 'date' },
                          returning_date: { type: 'date' },
                          city: { type: 'string' }
                        }
                      }
                    }
                  }
                }
              }
            },
            '400': {
              description: 'Bad request',
              content: {
                'application/json': {
                  schema: {
                    type: 'object',
                    properties: {
                      error: {
                        type: 'string'
                      }
                    }
                  }
                }
              }
            }
          }
        },
        '/aeroplanes/{:id}/reservations': {
          get: {
            summary: 'Get all payment reservations made on an aeroplane',
            tags: ['Reservations'],
            description: 'Retrieves a list of all reservations made for an aeroplane',
            parameters: [
              {
                name: 'id',
                in: 'path',
                required: true,
                description: 'Aeroplane ID',
                schema: {
                  type: 'integer'
                }
              }
            ],
            responses: {
              '200': {
                description: 'Successful',
                content: {
                  'application/json': {
                    schema: {
                      type: 'array',
                      items: {
                        type: 'object',
                        properties: {
                          reservation_date: { format: 'date' },
                          returning_date: { format: 'date' },
                          city: { type: 'string' }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        },
        '/aeroplanes/{aeroplane_id}/reservations/{reservation_id}': {
          delete: {
            summary: 'Delete reservation ID',
            tags: ['Reservations'],
            description: 'Deletes a reservation for a given aeroplane',
            parameters: [
              {
                name: 'aeroplane_id',
                in: 'path',
                required: true,
                description: 'Reservation ID',
                schema: {
                  type: 'integer'
                }
              },
              { name: 'reservation_id',
                in: 'path',
                required: true,
                description: 'Reservation ID',
                schema: {
                  type: 'integer'
                } }
            ],
            responses: {
              '204': {
                description: 'Reservation deleted successfully'
              }
            }
          }
        },
        '/aeroplanes/{aeroplane_id}/reservations/reservation_id': {
          get: {
            summary: 'Return a given a partivular reservation for a particular aeroplane by ID',
            tags: ['Reservations'],
            description: 'Returns a particular aeroplane reservation for a particular aeroplane',
            parameters: [
              {
                name: 'aeroplane_id',
                in: 'path',
                required: true,
                description: 'Aeroplane ID',
                schema: {
                  type: 'integer'
                }
              },
              {
                name: 'reservation_id',
                in: :path,
                required: true,
                description: 'Reservation ID',
                schema: {
                  type: 'integer'
                }
              }
            ],
            responses: {
              '200': {
                description: 'Successful',
                content: {
                  'application/json': {
                    schema: {
                      type: 'array',
                      items: {
                        type: 'object',
                        properties: {
                          id: { type: 'integer' },
                          reservation_date: { format: 'date' },
                          returning_date: { format: 'date' },
                          city: { type: 'string' }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
# rubocop:enable Metrics/BlockLength
