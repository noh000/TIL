from typing_extensions import TypedDict, Annotated
from langchain_experimental.utilities import PythonREPL
from state import State
from llm import llm
from prompts import generate_code_prompt, generate_answer_prompt


class CodeBlock(TypedDict):
    code: Annotated[str, ..., '바로 실행 가능한 파이썬 코드']


def generate_code(state: State):
    prompt = generate_code_prompt.format(
        question=state['question'],
        dataset=state['dataset']
    )
    s_llm = llm.with_structured_output(CodeBlock)
    res = s_llm.invoke(prompt)
    return {'code': res['code']}


def execute_code(state: State):
    repl = PythonREPL()
    result = repl.run(state['code'])
    return {'result': result.strip()}


def generate_answer(state: State):
    prompt = generate_answer_prompt.format(
        question=state['question'],
        code=state['code'],
        result=state['result']
    )
    res = llm.invoke(prompt)
    return {'answer': res}