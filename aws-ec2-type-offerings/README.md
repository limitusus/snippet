# offerings-to-table

Converts Amazon EC2 instance type offerings to table format.
Currently accepted format is `csv`.

## Usage

```console
aws ec2 describe-instance-type-offerings --output json --location-type availability-zone --query 'InstanceTypeOfferings' > offerings.json
./offerings-to-table offerings.json > offerings.csv
```
