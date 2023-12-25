import clips
from tkinter import *

max_number_of_buttons = 100 # Set an initial maximum number of buttons


def load_files(properties):
    with open('../resources/env.properties', 'r') as file:
        for line in file:
            name, full_name = line.strip().split('=')
            properties[name] = full_name


def get_properties(name):
    return properties.get(name, "")


def get_current_id():
    return str(clips_env.eval('(find-all-facts ((?f state-list)) TRUE)')[0]['current'])


def get_curent_interface():
    return clips_env.eval(f'(find-all-facts ((?f Interface)) (eq ?f:id {get_current_id()}))')[0]


def update_answers():
    books = get_curent_interface()['books']

    for id, text in enumerate(all_text_ans):
        if id < len(books):
            text.set(get_properties(str(books[id])))
            all_ans[id].grid(row=id + 1, column=0)
        else:
            text.set('')
            all_ans[id].grid_remove()


def update_buttons():
    valid_answers = get_curent_interface()['valid-answers']

    for id, text_var in enumerate(all_text_vars):
        if id < len(valid_answers):
            text_var.set(get_properties(str(valid_answers[id])))
            all_buttons[id].grid(row=id + 1, column=0)
        else:
            text_var.set('')
            all_buttons[id].grid_remove()


def button_command(id):
    valid_answers = get_curent_interface()['valid-answers']
    clips_env._facts.assert_string(f'(next {get_current_id()} {valid_answers[id]})')
    clips_env._agenda.run()
    update_textes(False)


def back_button_command():
    Interface = get_curent_interface()
    state = str(Interface['state'])
    curr_id = get_current_id()

    if state == 'final':
        clips_env.reset()
        clips_env._agenda.run()
        update_textes(False)
        return

    if state == 'initial':
        clips_env._facts.assert_string('(next ' + curr_id + ')')
        clips_env._agenda.run()

    if state == 'middle':
        clips_env._facts.assert_string('(prev ' + curr_id + ')')
        clips_env._agenda.run()

    update_textes(False)



#====================================================================



def update_textes(start):
    Interface = get_curent_interface()
    state = str(Interface['state'])

    if state == 'initial':
        text_button_back.set('Start')
    elif state == 'final':
        text_button_back.set('Restart')
    else:
        text_button_back.set('Back')

    text_question.set(get_properties(Interface['display']))

    if start == False:
        if state == 'final':
            #question.configure(font='Helvetica 18 bold', relief=GROOVE, padx=10, pady=10, fg='#e9736a', bd=3)

            update_answers()
        else:
            for i in all_ans:
                i.grid_forget()

            question.configure(textvariable=text_question, padx=1, pady=7, bg='#F5F5DC', fg='#FFA500',
                               font='Helvetica 12 bold', bd=1, relief=FLAT)
            question.grid(row=0, column=0)
            empty_space.grid(row=len(all_text_vars) + 1, column=0)
            button_back.grid(row=len(all_text_vars) + 2, column=0, sticky='we')

    update_buttons()






if __name__ == '__main__':
    root = Tk()
    root.geometry('1280x600')
    root.config(bg='#F5F5DC')
    root.title('Best book of the 21st century')

    clips_env = clips.Environment()
    clips_env.load('clips.clp')
    clips_env.reset()
    clips_env._agenda.run()

    properties = {}
    load_files(properties)

    text_button_back = StringVar()
    text_question = StringVar()

    all_text_vars = []
    all_buttons = []

    for _ in range(max_number_of_buttons):
        text_var = StringVar()
        all_text_vars.append(text_var)
        button = Button(root, textvariable=text_var, width=90, padx=2, pady=2,
                        command=lambda i=_: button_command(i), borderwidth=3, activebackground='#9ada7d',
                        bg='#0099cc', fg='#0b0b0b', font='Helvetica 10 bold')
        all_buttons.append(button)
        button.grid_remove()

    update_textes(start=True)

    all_text_ans = []
    all_ans =[]
    for i in range(4):
        text = StringVar()
        all_text_ans.append(text)
        answer = Label(root, textvariable=text, pady=7, bg='#F5F5DC', fg='#FFA500',
                         font='Helvetica 18 bold')
        all_ans.append(answer)
        answer.grid_remove()




    question = Label(root, textvariable=text_question, pady=7, bg='#F5F5DC', fg='#FFA500',
                     font='Helvetica 12 bold')



    empty_space = Label(root, text='', bg='#F5F5DC', height=2)

    button_back = Button(root, textvariable=text_button_back, width=90, padx=2, pady=2, command=back_button_command,
                         borderwidth=4, activebackground='#9ada7d', bg='#0099cc', fg='#0b0b0b',
                         font='Helvetica 10 bold')

    question.grid(row=0, column=0)
    empty_space.grid(row=2, column=0)
    button_back.grid(row=2, column=0, sticky='we')

    root.mainloop()
