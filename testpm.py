from pymongo import MongoClient
import pprint
client = MongoClient()
client = MongoClient("mongodb://localhost")
db = client.inventory
coll = db.store
di = []
for i in coll.find({"status":"D"}):
    di.append({"Item":i["item"],"Quantity": i["qty"]})
for i in di:
    print "Item = {},Quantity= {} ".format( i["Item"], i["Quantity"])

