# database-sharding
Test performance with Horizontal/Vertical Sharding in PostgreSQL

- run `docker-compose up -d`
- make a index for table `users` by column `date_of_birth` for testing
- generate 1 000 000 users use siege, with 50 concurrent and 20 000 requests
- for testing vertical/horizontal sharding need to run script into `/build/` directory.

For test performance i used siege.

Result of search by `date_of_birth` with 50 concurrent and 50 request.

|                                   | **AVG Response Time, sec** | **Longest transaction, sec** |
|:---------------------------------:|:------:|:------:|
|        **Without sharding**       |  0.39  |  0.77 |
|       **Horizontal sharding**     | 0.05 | 0.10 |
|     **Vertical sharding**         |  0.56 | 0.56  |

Result of search by `lastname` with 50 concurrent and 50 request.

|                                   | **AVG Response Time, sec** | **Longest transaction, sec** |
|:---------------------------------:|:------:|:------:|
|        **Without sharding**       |  0.70  |  1.28 |
|       **Horizontal sharding**     | 0.05 | 0.12 |
|     **Vertical sharding**         |  0.79 | 1.68 |

Result of inserting operation  with 50 concurrent and 50 request.

|                                   | **AVG Response Time, sec** | **Longest transaction, sec** |
|:---------------------------------:|:------:|:------:|
|        **Without sharding**       |  0.06  |  0.13 |
|       **Horizontal sharding**     | 0.15 | 0.41 |
|     **Vertical sharding**         |  0.07 | 0.28  |
