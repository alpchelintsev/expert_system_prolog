domains

  spisok = string*

predicates

  main
  input_data(string,string)    % ���� ������
  get_sreda(string)            % ���������� �������� ���������� "�����"
  get_conc(string)             % ���������� �������� ���������� "������������"
  get_temp(string)             % ���������� �������� ���������� "�����������"
  poyasnenie(spisok)
  ask(integer)                 % ���������� �����������
  why(spisok)
  append(spisok,spisok,spisok) % ���������� ���� �������
  is(string,string,string)     % �����, ������������ ����� ������
  mater_v(string,spisok)       % ������� ���� ������
  sreda(string,spisok)
  futerovka(string,spisok)
  mater_f(string,spisok)
  temp(string,string,spisok)
  type_o(string,spisok)

database - tmp

  % ������, ��������� �������������
  sr(string)   % �����
  conc(string) % ������������
  t(string)    % �����������

clauses

  main:-
  	write("�������� ����:"),nl,nl,
  	write("1. �������� �����"),nl,
  	write("2. �������� ���������"),nl,
  	write("3. ��� ��������"),nl,
  	write("4. �����"),nl,nl,
  	write("��� ����� > "),
  	readint(Num),nl,
  	ask(Num).

  input_data(ParamName,Dt):-
  	write("������� �������� ��������� '"),
  	write(ParamName),
  	write("' > "),
  	readln(Dt).

  get_sreda(S):-
  	sr(S),!.

  get_sreda(S):-
  	input_data("�����",S),
  	assert(sr(S)).

  get_conc(C):-
  	conc(C),!.

  get_conc(C):-
  	input_data("������������",C),
  	assert(conc(C)).

  get_temp(T):-
  	t(T),!.

  get_temp(T):-
  	input_data("�����������",T),
  	assert(t(T)).

  poyasnenie(List):-
  	write("\n������� �������� �� ��������� ��������� �����������: "),nl,
  	why(List),nl,nl,
  	ask(4).

  ask(1):-
  	mater_v(Y,List),
  	write("\n�������� �����: ",Y),nl,
  	poyasnenie(List).

  ask(2):-
  	mater_f(Y,List),
  	write("\n�������� ���������: ",Y),nl,
  	poyasnenie(List).

  ask(3):-
  	type_o(Y,List),
  	write("\n��� ������������: ",Y),nl,
  	poyasnenie(List).

  ask(4):-
  	write("������ ����� ������� ��� ����!").

  ask(_):-
  	write("\n�������� ����.").

  why([]).

  why([X|Y]):-
  	write(X),
  	why(Y).

  append([],L,L).
  
  append([N|L1],L2,[N|L3]):-
  	append(L1,L2,L3).

  is("�������","����������� ��������",F):-
  	F="\n������� = ����������� ��������".

  is("������� �������","�������",F):-
  	F="\n������� ������� = �������".

  is("��������� �������","�������",F):-
  	F="\n��������� ������� = �������".

  mater_v("�������������� �����",List):-
  	sreda("����������������� �������",List1),  	
  	append(["\n�������� ����� = �������������� �����, �.�.\n"],List1,List2),
  	append(List2,["."],List).

  mater_v("������������ �����",List):-
  	sreda("������������ �������",List1),  	
  	append(["\n�������� ����� = ������������ �����, �.�.\n"],List1,List2),
  	append(List2,["."],List).

  sreda("����������������� �������",List):-
  	sreda("�������",List1),
  	get_conc(C),
  	C=">70%",
  	append(["\n����� = ����������������� �������, �.�.\n"],List1,List2),
  	append(List2,["\n\n� ������������ >70%"],List).

  sreda("������������ �������",List):-
  	sreda("�������",List1),
  	get_conc(C),
  	C="<70%",
  	append(["\n����� = ������������ �������, �.�.\n"],List1,List2),
  	append(List2,["\n\n� ������������ <70%"],List).

  sreda("�������",List):-
  	get_sreda(S1),
  	is(S1,"�������",S2),
  	List=["\n����� = �������, �.�.\n",S2,"\n����� = ",S1,"."].

  sreda("����������� ��������",List):-
  	is(K,"����������� ��������",S1),
  	get_sreda(S2),
  	is(S2,K,S3),
  	List=["\n����� = ����������� ��������, �.�.\n",S1,S3,"\n����� = ",S2,"."].

  futerovka("����",List):-
  	sreda("����������� ��������",List1),
  	append(["\n��������� = ����, �.�.\n"],List1,List).

  mater_f("������",List):-
  	futerovka("����",List1),
  	get_sreda(S),
  	S="��������� �������",
  	append(["\n�������� ��������� = ������, �.�.\n"],List1,List2),
  	append(List2,["\n\n� ����� = ��������� �������."],List).

  mater_f("���������",List):-
  	futerovka("����",List1),
  	get_sreda(S),
  	S="������� �������",
  	append(["\n�������� ��������� = ���������, �.�.\n"],List1,List2),
  	append(List2,["\n\n� ����� = ������� �������."],List).

  temp("������ 100 ��������","����������� �������",List):-
  	List=["\n����������� = ������ 100 ��������."].

  temp("������ 100 ��������","������������������",List):-
  	List=["\n����������� = ������ 100 ��������."].

  type_o(Tp,List):-
  	get_temp(T),
  	temp(T,Tp,List1),
  	append(["\n��� �������� = ",Tp,", �.�.\n"],List1,List).

goal

  main.