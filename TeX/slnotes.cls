\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{slnotes}[2015/06/13]
\newif\if@slchem\@slchemfalse
\DeclareOption{chem}{\@slchemtrue\@slchemformulatrue}
\newif\if@slchemformula\@slchemformulafalse
\DeclareOption{chemformula}{\@slchemformulatrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
%
\LoadClass[a4paper,11pt,twocolumn]{report}
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{thmtools}
\RequirePackage{mathtools}
\RequirePackage[bf,sf,small,compact]{titlesec}
\RequirePackage{longtable}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{ltablex}
\RequirePackage{varwidth}
%\RequirePackage{multirow}
\RequirePackage[math-style=ISO]{unicode-math}
\RequirePackage{fontspec}
\RequirePackage{siunitx}
\RequirePackage[inline]{enumitem}
\RequirePackage[margin=0.5in,footskip=0.25in]{geometry}
\RequirePackage{ifxetex}
\ifxetex
    \RequirePackage[protrusion={true,nocompatibility},final,factor=1100]{microtype}
\else
    \RequirePackage[activate={true,nocompatibility},final,factor=1100]{microtype}
\fi
\RequirePackage{tikz}
\RequirePackage{subfiles}
\if@slchemformula\RequirePackage{chemformula}\fi
\if@slchem
    \RequirePackage[synchronize=true]{chemmacros}
    \RequirePackage{chemfig}
    \RequirePackage[level]{fmtcount}
\fi

\usetikzlibrary{arrows.meta}

\setmainfont[Ligatures=TeX]{Palatino Linotype}
\setsansfont[Ligatures=TeX]{Source Sans Pro}
\setmathfont{Cambria Math}
\newfontfamily\mffamily{Cambria}
\DeclareTextFontCommand{\slmf}{\mffamily\itshape}

\def\ttl@mkchap@i#1#2#3#4#5#6#7{%
  \ttl@assign\@tempskipa#3\relax\beforetitleunit
%  \vspace*{\@tempskipa}%
  \global\@afterindenttrue
  \ifcase#5 \global\@afterindentfalse\fi
  \ttl@assign\@tempskipb#4\relax\aftertitleunit
  \ttl@topmode{\@tempskipb}{%
    \ttl@select{#6}{#1}{#2}{#7}}%
  \ttl@finmarks  % Outside the box!
  \@ifundefined{ttlp@#6}{}{\ttlp@write{#6}}}

% Fucking people like their space a lot
\def\LT@makecaption#1#2#3{%
  \LT@mcol\LT@cols c{\hbox to\z@{\hss\parbox[t]\LTcapwidth{%
    \sbox\@tempboxa{#1{#2: }#3}%
    \ifdim\wd\@tempboxa>\hsize
      #1{#2: }#3%
    \else
      \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
    \fi
    \endgraf}%\vskip\baselineskip}%
  \hss}}}
\setcounter{LTchunksize}{100}

\titleformat{\chapter}[hang]{\Large\sffamily\bfseries}{\thechapter}{1em}{}
\titleformat{\part}[hang]{\LARGE\sffamily\bfseries}{\thepart}{1em}{}
\titleclass{\part}{straight}
\titleclass{\chapter}{straight}
\titlespacing{\part}{0pt}{0pt}{0pt}
\titlespacing{\chapter}{0pt}{0pt}{0pt}
\titlespacing{\section}{0pt}{0pt}{0pt}
\titlespacing{\subsection}{0pt}{0pt}{0pt}
\titlespacing{\subsubsection}{0pt}{0pt}{0pt}
\titlespacing{\paragraph}{0pt}{0pt}{1em}
\titlespacing{\subparagraph}{0pt}{0pt}{1em}

\sisetup{math-micro = \mathrm{\mu}, text-micro = µ, range-phrase=--}

\newlist{slinenum}{enumerate*}{1}
\setlist[slinenum]{font=\normalfont\bfseries,label=(\alph*),itemjoin={{; }},itemjoin*={{; and }}}
\newlist{slinenumor}{enumerate*}{1}
\setlist[slinenumor]{font=\normalfont\bfseries,label=(\alph*),itemjoin={{; }},itemjoin*={{; or }}}
\setlist{font=\sffamily\bfseries,leftmargin=*,topsep=0pt,partopsep=0pt,itemsep=0pt}
\setlist[enumerate,1]{label=\arabic*}
\setlist[enumerate,2]{label=\Alph*}

\DeclareMathOperator*{\argmin}{arg\,min}
\DeclareMathOperator*{\argmax}{arg\,max}
\newcommand*{\solid}{\relax}
\let\solid\sld\let\sld\undefined
\newcommand*{\sld}[1][]{\symup{d}#1}
\newcommand*{\sldd}[2]{\frac{\symup{d}#1}{\symup{d}#2}}
\newcommand*{\slid}{\,\symup{d}}
\newcommand*{\sldef}[1]{\textbf{#1}}
\newcommand*{\sltbhdr}[1]{\multicolumn{1}{c}{\textbf{#1}}}
\newcommand*{\sltbcap}[2]{\addlinespace\caption{#1}\label{#2}\endlastfoot}
\newcommand*{\sl@textifmmode}[1]{\ifmmode\let\sl@textifmmode@\text\else\let\sl@textifmmode@\relax\fi\sl@textifmmode@{#1}}
\newcommand*{\sl@smashifhmode}[1]{\ifvmode\let\sl@smashifhmode@\relax\else\let\sl@smashifhmode@\smash\fi\sl@smashifhmode@{#1}}
%\newcommand*{\slcleardoublepagegoddamnit}{\clearpage\ifodd\c@page\else\hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi}

\declaretheoremstyle[spaceabove=0pt,spacebelow=0pt,headfont=\sffamily\bfseries,postheadspace=.5em,qed=\rule{0.7em}{0.7em},headpunct=\relax]{slthm}
\declaretheorem[name=Derivation,style=slthm,numbered=no]{slderiv}

\newlength{\slskip}
\slskip=4pt plus 1pt minus 1pt

\g@addto@macro\normalsize{%
\overfullrule=2cm%
\parindent=0pt%
\parskip=\the\slskip%
\textfloatsep=2\slskip%
\floatsep=2\slskip%
\intextsep=2\slskip%
\dbltextfloatsep=2\slskip%
\dblfloatsep=2\slskip%
\abovecaptionskip=\the\slskip%
\abovedisplayskip=\the\slskip%
\belowdisplayskip=\the\slskip%
\LTpre=\the\slskip%
\LTpost=\the\slskip%
\fboxsep=1pt%
\LTcapwidth=\textwidth}

\if@slchemformula
    \setchemformula{format=\mffamily}
    \newcommand*{\slnuclide}[3]{\mbox{\ch{_{#1}^{#2}#3}}}
    \newcommand*{\slch}[1]{\mbox{\ch{#1}}}
\fi

\if@slchem
    \setatomsep{2em}
    \setbondoffset{1pt}
    \setcrambond{0.4em}{}{}
    \enablebondjoin
	\renewcommand*\printatom[1]{\ensuremath{\symrm{#1}}}
    \newcommand*{\chemsuper}[2]{#1\rlap{${}^{#2}$}}
    \newcommand*{\chemsub}[2]{#1\rlap{${}_{#2}$}}
    \newcommand*{\chemlsuper}[2]{\llap{${}^{#2}$}\kern-\scriptspace#1}
    \newcommand*{\chemlsub}[2]{\llap{${}_{#2}$}\kern-\scriptspace#1}
    \newcommand*{\slchemprime}{\rlap{$\prime$}}
    \DeclareSIUnit{\ppm}{ppm}
    \newcommand*{\slcheckmark}{\tikz\fill[scale=0.4](0,.35) -- (.25,0) -- (1,.7) -- (.25,.15) -- cycle;}
    \newcommand*{\conc}[1]{\mbox{\ensuremath{[\ch{#1}]}}}
    \newcommand*\slstdc\circlehbar
    \newcommand*{\slEorr}[2]{\sl@smashifhmode{\ensuremath{E^\slstdc(\ch{#1}\text{/}\ch{#2})}}}
    \newcommand*{\slEo}{\sl@smashifhmode{\ensuremath{E^\slstdc}}}
    \newcommand*{\slEocell}{\sl@smashifhmode{\ensuremath{E^\slstdc_\text{cell}}}}
    \newcommand*{\sldHs}[1]{\sl@smashifhmode{\ensuremath{\Delta H_\text{#1}^\slstdc}}}
    \newcommand*{\slIE}{\textit{IE}}
    \newcommand*{\slEA}{\textit{EA}}
    \newcommand*{\slEa}{\sl@smashifhmode{\ensuremath{E_\text{a}}}}
    \newcommand*{\slBE}{\textit{BE}}
    \newcommand*{\slnIE}[1]{\sl@textifmmode{\ordinalnum{#1} \slIE}}
    \newcommand*{\slnEA}[1]{\sl@textifmmode{\ordinalnum{#1} \slEA}}
    \newcommand{\slhl}{t_{1/2}}
    \newcommand{\slrt}{\textit{rate}}
\fi
\endinput
