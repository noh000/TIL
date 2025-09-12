from langgraph.graph import StateGraph, START, END
from state import State
from nodes import generate_code, execute_code, generate_answer

builder = StateGraph(State)

# 노드들을 추가합니다.
builder.add_node("generate_code", generate_code)
builder.add_node("execute_code", execute_code)
builder.add_node("generate_answer", generate_answer)

# 노드들을 순차적으로 연결합니다.
builder.add_edge(START, "generate_code")
builder.add_edge("generate_code", "execute_code")
builder.add_edge("execute_code", "generate_answer")
builder.add_edge("generate_answer", END)

graph = builder.compile()