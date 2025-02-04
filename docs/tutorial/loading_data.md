Recon works best with NER data in the [Prodigy Annotation Format](https://prodi.gy/docs/api-interfaces#ner).

A single example in this format looks like

```JSON
{
  "text": "Apple updates its analytics service with new metrics",
  "spans": [{ "start": 0, "end": 5, "label": "ORG" }]
}
```

Recon does require that you have the tokens property set and will try to resolve any tokenization errors in your
data for you as well as add tokens if they don't already exist. If your data has already been tokenized (which is true if you used the ner_manual Prodigy recipe), Recon will skip the tokenization step.

Recon expects your data to be in a collection in a JSONL or JSON file.

!!!note
    More loaders for different file types (`CONLL`) will be added in future versions


## Loaders

Recon comes with a few loaders, `read_jsonl` and `read_json`. They're simple enough, they just load the data from disk and create instances of the typed `Example` class for each raw example.

The `Example` class provides some basic validation that ensures all spans have a text property (which they don't if you're using newer versions of Prodigy and the ner.manual recipe for annotation).

Everything in Recon is built to run on a single `Example` or a `List[Example]`.

Let's use the `read_jsonl` loader to load some annotated data created with Prodigy

!!!tip
    If you don't have any data available, you can use the data in the examples folder [here](https://github.com/kabirkhan/recon/tree/master/examples/data/skills). We'll be using this data for the first part of the tutorial.

```python
from recon.loaders import read_jsonl
from recon.types import Example


data = read_jsonl('examples/data/skills/train.jsonl')

assert isinstance(data[0], Example)
```

Now that we have some examples to work with, we can start examining our data.


## Next Steps

Once you have your data loaded, you can run other Recon functions on top of it to gain insights into the quality and completeness of your NER data as well as to start making corrections to the inconsistently annotated examples you almost certainly have (Don't worry, that's fine! Messy data is everywhere, even at the largest AI Companies, even in your favorite benchmark datasets as we'll see later)
