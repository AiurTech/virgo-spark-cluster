function keyValueSearch() {
	local key="$1"
	local file="$2"

	grep -A 2 $key $file | grep -oP '<value>(.*)</value>' | sed -n 's/.*<value>\([^<]*\)<\/value>.*/\1/p' 
}