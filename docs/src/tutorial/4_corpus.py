from pathlib import Path

import typer
from recon.corpus import Corpus
from recon.stats import get_ner_stats


def main(data_dir: Path):
    corpus = Corpus.from_disk(data_dir)
    corpus_stats = corpus.apply(get_ner_stats)
    for name, stats in corpus_stats.items():
        print(f"{name}")
        print("=" * 50)
        print(stats)


if __name__ == "__main__":
    typer.run(main)
