import clips
from tkinter import *

max_number_of_buttons = 6  # Set an initial maximum number of buttons


def get_properties(name):
    return properties.get(name, "")


def get_current_id():
    eval_str = '(find-all-facts ((?f state-list)) TRUE)'
    curr_id = str(clips_env.eval(eval_str)[0]['current'])
    return curr_id


def get_current_UIstate():
    curr_id = get_current_id()
    eval_str = '(find-all-facts ((?f UI-state)) ' + '(eq ?f:id ' + curr_id + '))'
    UIstate = clips_env.eval(eval_str)[0]
    return UIstate


def update_buttons():
    UIstate = get_current_UIstate()
    valid_answers = UIstate['valid-answers']

    for id, text_var in enumerate(all_text_vars):
        if id < len(valid_answers):
            text_var.set(get_properties(str(valid_answers[id])))
            all_buttons[id].grid(row=id + 1, column=0)
        else:
            text_var.set('')
            all_buttons[id].grid_remove()


def update_textes(start=False):
    UIstate = get_current_UIstate()
    state = str(UIstate['state'])

    if state == 'initial':
        text_button_back.set('Start')
    elif state == 'final':
        text_button_back.set('Restart')
    else:
        text_button_back.set('Back')

    text_question.set(get_properties(UIstate['display']))

    if not start:
        if state == 'final':
            question.configure(font='Helvetica 18 bold', relief=GROOVE, padx=10, pady=10, fg='#e9736a', bd=3)
        else:
            question.configure(textvariable=text_question, padx=1, pady=7, bg='#F5F5DC', fg='#FFA500',
                               font='Helvetica 12 bold', bd=1, relief=FLAT)

    update_buttons()

    if not start:
        question.grid(row=0, column=0)
        empty_space.grid(row=len(all_text_vars) + 1, column=0)
        button_back.grid(row=len(all_text_vars) + 2, column=0, sticky='we')


def ans_button_command(id):
    curr_id = get_current_id()
    UIstate = get_current_UIstate()
    valid_answers = UIstate['valid-answers']
    answer = valid_answers[id]
    clips_env._facts.assert_string('(next ' + curr_id + ' ' + answer + ')')
    clips_env._agenda.run()
    update_textes()


def back_button_command():
    UIstate = get_current_UIstate()
    state = str(UIstate['state'])
    curr_id = get_current_id()

    if state == 'final':
        clips_env.reset()
        clips_env._agenda.run()
        update_textes()
        return

    if state == 'initial':
        clips_env._facts.assert_string('(next ' + curr_id + ')')
        clips_env._agenda.run()

    if state == 'middle':
        clips_env._facts.assert_string('(prev ' + curr_id + ')')
        clips_env._agenda.run()

    update_textes()


if __name__ == '__main__':
    root = Tk()
    root.geometry('720x400')
    root.config(bg='#F5F5DC')

    clips_env = clips.Environment()
    clips_env.load('clips.clp')
    clips_env.reset()
    clips_env._agenda.run()

    properties = {}

    text_button_back = StringVar()
    text_question = StringVar()

    file = open('../resources/env.properties', 'r')
    data = file.readlines()

    for line in data:
        name, full_name = line.replace('\n', '').split('=')
        properties[name] = full_name

    file.close()

    all_text_vars = []
    all_buttons = []

    for _ in range(max_number_of_buttons):
        text_var = StringVar()
        all_text_vars.append(text_var)
        button = Button(root, textvariable=text_var, width=90, padx=2, pady=2,
                        command=lambda i=_: ans_button_command(i), borderwidth=3, activebackground='#9ada7d',
                        bg='#0099cc', fg='#0b0b0b', font='Helvetica 10 bold')
        all_buttons.append(button)
        button.grid_remove()

    update_textes(start=True)

    root.title('Best book of 21st century')

    question = Label(root, textvariable=text_question, pady=7, bg='#F5F5DC', fg='#FFA500', font='Helvetica 12 bold')
    empty_space = Label(root, text='', bg='#F5F5DC', height=2)

    button_back = Button(root, textvariable=text_button_back, width=90, padx=2, pady=2, command=back_button_command,
                         borderwidth=4, activebackground='#9ada7d', bg='#0099cc', fg='#0b0b0b',
                         font='Helvetica 10 bold')

    question.grid(row=0, column=0)
    empty_space.grid(row=1, column=0)
    button_back.grid(row=2, column=0, sticky='we')

    root.mainloop()
