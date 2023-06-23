import json 
def lambda_handler(event, context):
    print(json.dumps(event)) 
    reply = {} 
    #No Need to do json.dumps() in every places
    reply['body'] = "Lambda query" 
    reply["statusCode"] = 200 
    reply.update({"headers": {"Content-Type": "application/json"}})
    return reply