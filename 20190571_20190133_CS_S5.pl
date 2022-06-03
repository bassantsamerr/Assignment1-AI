%Task1
myappend( [], L, L).
myappend( [H|T], L2, [H|NT]):-
	myappend(T, L2, NT).

mymember(X,[X|_]).
mymember(X,[_|Xs]) :- member(X,Xs).

mynot( X ) :- X, !, fail.
mynot( _ ).

studentsInCourse(Course,Students):-
    studentsInCourse([],Students,Course).

studentsInCourse(TmpList,[[X,G]|T],Course):-
    student(X,Course,G),
    mynot(mymember(X,TmpList)),!,
    myappend([X,G],TmpList, NewTmpList),
    studentsInCourse(NewTmpList,T,Course).

studentsInCourse(_,[],_):-
    !.

%Task2
mylength([],0).
mylength([_|T],Num):-
mylength(T,Num1),
Num is 1 +Num1.

numStudents(Course, Num):-
   studentsInCourse(Course,Students),
   mylength(Students,Num).

%Task3
mymax([X],X) :- !, true.
mymax([X|Xs], M):- mymax(Xs, M), M >= X.
mymax([X|Xs], X):- mymax(Xs, M), X >  M.

getStudentGrade(N,MaxGrade):-
    getStudentGrade([],MaxGrade,N).


getStudentGrade(TmpList,[G|T],N):-
    student(N,_,G),
    mynot(mymember(G,TmpList)),!,
    myappend([G],TmpList, NewTmpList),
    getStudentGrade(NewTmpList,T,N).

getStudentGrade(_,[],_):-
    !.
maxStudentGrade(N,MaxGrade):-
getStudentGrade(N,Max),
mymax(Max,MaxGrade).

%Task4
myreverse(Xs, Ys) :-
	myreverse(Xs, [], Ys, Ys).
myreverse([], Ys, Ys, []).
myreverse([X|Xs], Rs, Ys, [_|B]) :-
        myreverse(Xs, [X|Rs], Ys, B).
splitRev(0,[]).
splitRev(N,[H|T]) :-
	N1 is N//10,
	H is N-(N//10)*10,
	splitRev(N1,T).

split(N,List1) :-
	splitRev(N,List2),
	myreverse(List1,List2).

number(0,'zero').
number(1,'one').
number(2,'two').
number(3,'three').
number(4,'four').
number(5,'five').
number(6,'six').
number(7,'seven').
number(8,'eight').
number(9,'nine').
getGrade(_,[],_):-
    !.

getGrade(Name,Course,DigitsWords):-
    getGrade([],DigitsWords,Name,Course).

getGrade(TmpList,[G|T],Name,Course):-
    student(Name,Course,G),
    mynot(mymember(Name,TmpList)),!,
    myappend([G],TmpList, NewTmpList),
    getGrade(NewTmpList,T,Course).
/*
getGrade(_,[],_):-
    !.
*/

toword([], []).
toword([H|T], [TH|TT]) :-
   number(H, TH),
   toword(T, TT).

gradeInWords(Name,Course,DigitsWords):-
	getGrade(Name,Course,X),
	split(X,Z),
	toword(Z,DigitsWords).

















