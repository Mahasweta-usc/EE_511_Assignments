import os
from flask import Flask, request, render_template, redirect, url_for
import urllib.parse, urllib.request, json, pickle 
dirname = os.path.dirname(__file__)

app = Flask(__name__, template_folder=os.path.join(dirname,'templates'))
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0


remaining = list()
file = None
user = None
json_url = "https://storage.cloud.google.com/labeled_vaxx/"
image_url = "https://storage.cloud.google.com/procvaxx/"

def read_json(link):	
	with urllib.request.urlopen(link) as stream:
		print(stream.read())
		data = json.loads(stream.read())
		return data

@app.route('/')
def initial():
	return render_template('login.html',warning="")
	

@app.route('/login',methods=['POST'])
def login(): 
	global user
	if request.method == 'POST': 
		user = request.form.get('nm',None) 
		if user:
			return redirect(url_for('form_display',user=user)) 
		else:
			return render_template('login.html',warning="***Please Enter Valid Username***")





@app.route('/<user>')
def form_display(user):
	global remaining,file
	#read list of files yet to be annotated
	with open(os.path.join(dirname,"test.txt"), "rb") as fp:   # Unpickling
			remaining = pickle.load(fp)

	#if queue not empty 

	if len(remaining) > 1:
		file = remaining[0]

		if file[0] == 'R':
			status = "This post has been marked for review"
		else:
			status = ""

		file_prox = file.strip("R")
		image = urllib.parse.urljoin(image_url,file_prox.strip("xxx-").replace('json','png'))
		print(image)
		filepath = os.path.join(dirname,"raw_data",file_prox)
		with open(filepath,'r') as ip:
			contents = json.load(ip)

		try:
			caption = contents["node"]["edge_media_to_caption"]["edges"][0]["node"]["text"]
		except:
			caption = ""
		try:
			image_text = contents['embed_text']
		except:
			image_text = " "

		text = "<br/>Caption:<br/>" + caption + "<br/><br/>Image Text:<br/>" + image_text

		

		return render_template('labeling_template.html',name=user,count= str(remaining[-1].get(user,0)),image=image,text=text,status=status)
	else:
		return redirect(url_for('finish')) 



@app.route('/input', methods=['POST'])
def form_update():		
	global remaining,file
	# print(request.form)
	# if request.method == 'POST':
	try:	

		if request.form['action'] == "Submit":

			remaining.remove(file)
			remaining[-1][user] = remaining[-1].get(user,0) + 1

			file = file.strip("R")

			sentiment = request.form.get('senti',None) #,'label']
			label = request.form.get('label',None)

			print(sentiment,label)

			if label and sentiment:

				filepath = os.path.join(dirname,"raw_data",file)
				with open(filepath,'r') as ip:
						contents = json.load(ip)

				try:
					test = contents["Annotations"]
				except:
					contents["Annotations"] = {}

				
				contents["Annotations"][user] = {"Stance": sentiment,"Misinformation": label}

				with open(os.path.join(dirname,"labeled_data",file),"w") as op:
					json.dump(contents,op)

				

				

		elif request.form['action'] == "Delete":
			print(file)
			remaining.remove(file)

		elif request.form['action'] == "Skip":
			remaining.remove(file)
			if 'R' not in file:
				file = 'R' + file
			print(file)
			remaining.insert(len(remaining)-1,file)

		print(len(remaining), remaining)

		with open(os.path.join(dirname,"test.txt"), "wb") as fp:   #Pickling
			pickle.dump(remaining, fp)

	except Exception as e:
		print(e)
		pass

	return form_display(user=user)	


@app.route('/finish')
def finish():
	return "Annotations Complete. Thank You"



if __name__ == '__main__':
    app.run(debug=True)