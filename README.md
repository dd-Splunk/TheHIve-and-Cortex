# The Hive and Cortex

## Important note

Make sure you disable zScaler to avoid SSL connections issues

## Steps

- Launch Cortex: 
  ```bash
   docker compose up -d elasticsearch cortex
  ```

- Initialize the underlying DB by opening in a browser: `http://localhost:9001`

- Update Database:

![Cortex - Update DB](./assets/Cortex - Update DB.png)

- Create the initial superadmin user:

![Cortex - Create admin](assets/Cortex - Create admin.png)

- Login as superadmin:

![Cortex - Initial Login](assets/Cortex - Initial Login.png)

- Select the "Users" tab:

![Cortex - Select Users tab](assets/Cortex - Select Users tab.png)

- Create the API key for the superadmin:

![Cortex - Create API](assets/Cortex - Create API.png)

- Copy the API key to the clipboard

![Cortex - Copy API to clipboard](assets/Cortex - Copy API to clipboard.png)

- Open a terminal and start the Cortex configuration:
  ```bash
  ./setup.sh <pasted API key>
  ```

- Launch theHIve: 
  ```bash
  docker compose up -d thehive
  ```

- Wait one minute ( theHive is starting up)

- Login as superadmin *( admin / secret )*

- Check the Cortex integration ( should be green )



## References

https://chinyati.medium.com/the-hive-cortex-through-docker-installation-e50cbadb6cb0
https://github.com/chinyati/Article-Resources

