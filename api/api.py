from flask import Flask, request, jsonify
import mlflow.pyfunc

app = Flask(__name__)

# Detalles del modelo registrado
MODEL_NAME = "my_model"
MODEL_STAGE = "Production"
MODEL_URI = f"models:/{MODEL_NAME}/{MODEL_STAGE}"

# Carga el modelo desde el registro de MLflow
model = mlflow.pyfunc.load_model(MODEL_URI)

@app.route("/predict", methods=["POST"])
def predict():
    data = request.get_json(force=True)
    # Se espera que la entrada sea una lista de vectores de características, por ejemplo: [[1.2, 3.4, 5.6, 7.8], ...]
    prediction = model.predict(data)
    return jsonify({"prediction": prediction.tolist()})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
