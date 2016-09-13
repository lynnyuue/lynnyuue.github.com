---
layout: post
title: "Introduced a number of important language recognition terms"
description: "antlr4 learning notes"
category: java 
tags: [antlr4,java]
---
{% include JB/setup %}

### Language
A language is a set of valid sentences.
Sentences are composed of phrases, which are composed of sub-phrases, and so on.

### Grammar
A grammar formally defines the syntax rules of a language.

Each rule in a grammar expresses the structure of a sub-phrase.

Syntax tree or parse tree this represents the structure of the sentence where each sub-tree root gives an abstract name to the elements beneath it.

The sub-tree roots correspond to grammar rule names.
The leaves of the tree are symbols or tokens of the sentence.

### Token
A token is a vocabulary symbol in a language.
These can represent a category of symbols such as 'identifier' or can represent a single operator or keyword.

### Lexer or tokenizer
This breaks up an input character stream into tokens.
A lexer performs lexical analysis.

### Parser

A parser checks sentences for membership in a specific language by checking the sentence's structure against the rules of a grammar.
The best analogy for parsing is traversing a maze, comparing words of a sentence to words written along the floor to go form entrance to exit.