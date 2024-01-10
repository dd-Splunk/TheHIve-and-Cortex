FROM alpine
RUN apk add --no-cache --upgrade curl
ADD splunk-init.sh .
RUN chmod +x splunk-init.sh
CMD ["/splunk-init.sh"]
