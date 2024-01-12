# The Hive and Cortex

This project was initiated to support a demonstration of Splunk SOAR integration
with Cortex and TheHive.

I needed to build a minimal working stack with Cortex / TheHive to test some
SOAR playbooks that will interact with the stack.

## Steps

- Launch Cortex:

  ```bash
   docker compose up -d elasticsearch cortex
  ```

- Initialize the underlying DB by opening in a browser: `http://localhost:9001`

- Update Database:

![Cortex - Update DB](/assets/Cortex%20-%20Update%20DB.png)

- Create the initial superadmin user:

![Cortex - Create admin](/assets/Cortex%20-%20Create%20admin.png)

- Login as superadmin:

![Cortex - Initial Login](/assets/Cortex%20-%20Initial%20Login.png)

- Select the "Users" tab:

![Cortex - Select Users tab](/assets/Cortex%20-%20Select%20Users%20tab.png)

- Create the API key for the superadmin:

![Cortex - Create API](/assets/Cortex%20-%20Create%20API.png)

- Copy the API key to the clipboard

![Cortex - Copy API to clipboard](/assets/Cortex%20-%20Copy%20API%20to%20clipboard.png)

- Open a terminal and start the Cortex configuration:

  ```bash
  ./setup.sh <pasted API key>
  ```

- Wait one minute ( theHive is starting up)

- Login as superadmin *( admin / secret )*

- Check the Cortex integration ( should be green )

## References

<https://chinyati.medium.com/the-hive-cortex-through-docker-installation-e50cbadb6cb0>
<https://github.com/chinyati/Article-Resources>
