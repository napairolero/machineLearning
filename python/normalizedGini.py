import numpy as np
import pandas as pd

def normalizedGini(actual,predicted):
	data = pd.DataFrame({'actual': actual, 'predicted': predicted})
	data = data.sort_index(by = "predicted", ascending = False) #how to deal with ties?
	actual = np.asarray(data['actual'])
	cumSum = np.cumsum(actual)
	sumTotal = len(actual)
	randomGuess = (np.array(np.arange(len(actual)))+1)/float(sumTotal)
	diff = cumSum/float(actual.sum()) - randomGuess
	return diff.sum()