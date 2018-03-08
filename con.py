from pymongo import MongoClient
import pprint
client = MongoClient()
client = MongoClient("mongodb://localhost")
db = client.inventory
coll = db.store
print "Number of records in store is {}".format(coll.count())
for i in coll.find({"status":"D"}):
    pprint.pprint(i)
    print "item name ={} ". format(i["item"])
    #print "itemName={}".format() 

