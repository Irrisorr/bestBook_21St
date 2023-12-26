import clips
from tkinter import *

'''========================================= Function to load properties ==========================================='''


def load_files(prop):
    with open('../resources/env.properties', 'r') as file:
        for line in file:
            name, full_name = line.strip().split('=')
            prop[name] = full_name


'''======================================= Functions to use from clips (getters) ===================================='''


def get_properties(name):
    return properties.get(name, "")


def slot():
    return str(clips_env.eval('(find-all-facts ((?f state-list)) TRUE)')[0]['current'])


def interface():
    return clips_env.eval(f'(find-all-facts ((?f Interface)) (eq ?f:slot {slot()}))')[0]


'''======================================= Function to set books at answering (setter) ============================='''


def set_answers():
    books = interface()['books']

    for answer, text in enumerate(answers_values):
        if answer < len(books):
            text.set(get_properties(str(books[answer])))
            answers[answer].grid(row=answer + 1, column=0)
            answers[answer].configure(font='Helvetica 18 bold', relief=GROOVE, padx=10, pady=10, fg='#e9736a', bd=3)


'''=============================== Functions to set buttons for an answering (setter)  =============================='''


def set_buttons():
    answers = interface()['answers']

    for button, text in enumerate(buttons_values):
        if button < len(answers):
            text.set(get_properties(str(answers[button])))
            buttons[button].grid(row=button + 1, column=0)
        else:
            buttons[button].grid_forget()


def button_command(answer):
    answers = interface()['answers']
    clips_env._facts.assert_string(f'(next {slot()} {answers[answer]})')
    clips_env._agenda.run()
    modify_text(False)


'''======================================= Function to set command for back & restart buttons ======================='''

def restart_button_command():
    clips_env.reset()
    clips_env._agenda.run()
    modify_text(False)


def func_button_command():
    state = str(interface()['state'])

    if state == 'begin':
        clips_env._facts.assert_string(f'(next {slot()})')
        clips_env._agenda.run()

    if state == 'middle' or state == 'end':
        clips_env._facts.assert_string(f'(previous {slot()})')
        clips_env._agenda.run()

    modify_text(False)


'''======================================= Function to modify text on display ======================================='''


def modify_text(condition):
    state = str(interface()['state'])

    if state == 'begin':
        func_button_text.set('Start')
    else:
        func_button_text.set('Back')

    question_text.set(get_properties(interface()['show']))

    if condition == False:
        if state == 'end':
            set_answers()
        else:
            for answer in answers:
                answer.grid_forget()

            question.configure(textvariable=question_text, padx=1, pady=7, bg='#F5F5DC', fg='#FFA500',
                               font='Helvetica 12 bold', bd=1, relief=FLAT)
            question.grid(row=0, column=0)
            indent.grid(row=len(buttons_values) + 2, column=0)
            func_button.grid(row=len(buttons_values) + 4, column=0, sticky='we')
            restart_button.grid(row=len(buttons_values) + 6, column=0, sticky='we')

    set_buttons()


'''================================================== MAIN FUNC ====================================================='''

if __name__ == '__main__':
    root = Tk()
    root.geometry('1280x600')
    root.config(bg='#F5F5DC')
    root.title('Best book of the 21st century')

    clips_env = clips.Environment()
    clips_env.load('clips.CLP')
    clips_env.reset()
    clips_env._agenda.run()

    properties = {}
    load_files(properties)
    func_button_text = StringVar()
    restart_button_text = StringVar()
    restart_button_text.set('Restart')
    question_text = StringVar()
    buttons_values = []
    buttons = []
    answers_values = []
    answers = []

    for i in range(20):
        text = StringVar()
        buttons_values.append(text)
        button = Button(root, textvariable=text, width=90, padx=2, pady=2,
                        command=lambda ii=i: button_command(ii), borderwidth=3, activebackground='#9ada7d',
                        bg='#0099cc', fg='#0b0b0b', font='Helvetica 10 bold')
        buttons.append(button)

    for i in range(20):
        text = StringVar()
        answers_values.append(text)
        answer = Label(root, textvariable=text, pady=7, bg='#F5F5DC', fg='#FFA500',
                       font='Helvetica 18 bold')
        answers.append(answer)

    modify_text(True)

    question = Label(root, textvariable=question_text, pady=7, bg='#F5F5DC', fg='#FFA500',
                     font='Helvetica 12 bold')
    indent = Label(root, text='', bg='#F5F5DC', height=1)

    func_button = Button(root, textvariable=func_button_text, width=90, padx=2, pady=2, command=func_button_command,
                         borderwidth=4, activebackground='#9ada7d', bg='#0099cc', fg='#0b0b0b',
                         font='Helvetica 10 bold')

    restart_button = Button(root, textvariable=restart_button_text, width=90, padx=2, pady=2, command=restart_button_command,
                         borderwidth=4, activebackground='#9ada7d', bg='#0099cc', fg='#0b0b0b',
                         font='Helvetica 10 bold')

    question.grid(row=0, column=0)
    indent.grid(row=2, column=0)
    func_button.grid(row=2, column=0, sticky='we')
    restart_button.grid(row=3, column=0, sticky='we')

    root.mainloop()
