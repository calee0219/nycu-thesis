%-------------------------------------------------------------------------------
% 本文件係採用創用 "CC 姓名標示-非商業性-相同方式分享 3.0 台灣" 授權條款授權
% (https://creativecommons.org/licenses/by-nc-sa/3.0/tw/legalcode)
%
% 本授權條款允許使用者重製、散布、傳輸以及修改著作，但不得為商業目的之使用。若使
% 用者修改該著作時，僅得依本授權條款或與本授權條款類似者來散布該衍生作品。使用時
% 必須按照著作人指定的方式表彰其姓名。
%-------------------------------------------------------------------------------
% Author: Borting Chen (bortingchen@gmail.com)
% Source: https://github.com/borting/nctu-thesis
%-------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2021/02/25 V2.7 by Borting Chen]

% Pre-load packages for pgfkeys
\RequirePackage{pgfkeys}
\RequirePackage{pgfopts}

%-------------------------------------------------------------------------------
% Document Options Declaration
%-------------------------------------------------------------------------------

% Inherent existing options from book document class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

% Declare options for thesis types: (default: master)
%   thesis(master) or dissertation(phd)
\newif\ifTHESISOPTIONmaster         \THESISOPTIONmastertrue
\newif\ifTHESISOPTIONphd            \THESISOPTIONphdfalse

\DeclareOption{master}{\THESISOPTIONmastertrue\THESISOPTIONphdfalse}
\DeclareOption{phd}{\THESISOPTIONmasterfalse\THESISOPTIONphdtrue}

% Declare options for the language used in thesis: (default: english)
%   en(English) or zh(Chinese)
\newif\ifTHESISOPTIONen             \THESISOPTIONentrue
\newif\ifTHESISOPTIONzh             \THESISOPTIONzhfalse

\DeclareOption{en}{\THESISOPTIONentrue\THESISOPTIONzhfalse}
\DeclareOption{zh}{\THESISOPTIONenfalse\THESISOPTIONzhtrue}

% Declare options for page numbering style: (default: nctupagenum)
%   nctupagenum - roman-style page numbering started from abstract
%   bookpagenum - roman-style page numbering started from titlepage

\newif\ifTHESISOPTIONnctupagenum    \THESISOPTIONnctupagenumtrue
\newif\ifTHESISOPTIONbookpagenum    \THESISOPTIONbookpagenumfalse

\DeclareOption{nctupagenum}
  {\THESISOPTIONnctupagenumtrue\THESISOPTIONbookpagenumfalse}
\DeclareOption{bookpagenum}
  {\THESISOPTIONnctupagenumfalse\THESISOPTIONbookpagenumtrue}

% Declare option to reserve pages when bookpagenum is used (default: 0)
%   reservedpages - number of authorizatoin page and approval page
\pgfkeys{%
  /thesis/.is family,
  /thesis,
  reservedpages/.store in=\reservedpages,
  reservedpages=0,
}

% Declare binding option: (default: disabled)
%   depending on the mode of thesis format:
%     review: disabled
%     draft : disabled
%     final : enabled
\newif\ifTHESISOPTIONbinding      \THESISOPTIONbindingfalse
\DeclareOption{binding}{\THESISOPTIONbindingtrue}

% Declare options for print modes: (default: draft)
%   review: for thesis writing (hide all front matters)
%   draft : draft for defence
%   final : print version
\newif\ifTHESISOPTIONreview         \THESISOPTIONreviewfalse
\newif\ifTHESISOPTIONdraft          \THESISOPTIONdrafttrue
\newif\ifTHESISOPTIONfinal          \THESISOPTIONfinalfalse

\DeclareOption{review}{\THESISOPTIONreviewtrue
                       \THESISOPTIONdraftfalse
                       \THESISOPTIONfinalfalse
                       \THESISOPTIONbindingfalse}

\DeclareOption{draft}{\THESISOPTIONreviewfalse
                      \THESISOPTIONdrafttrue
                      \THESISOPTIONfinalfalse
                      \THESISOPTIONbindingfalse}

\DeclareOption{final}{\THESISOPTIONreviewfalse
                      \THESISOPTIONdraftfalse
                      \THESISOPTIONfinaltrue
                      \THESISOPTIONbindingtrue}

% Declare watermark option: (default: disabled)
%   depending on the mode of thesis format:
%     review: never shown
%     draft : print "DRAFT" in the background
%     final : print the watermark specified by \watermark{}
\newif\ifTHESISOPTIONwatermark      \THESISOPTIONwatermarkfalse
\DeclareOption{watermark}{\THESISOPTIONwatermarktrue}

% Declare option for copyright page: (default: disabled)
\newif\ifTHESISOPTIONcopyright      \THESISOPTIONcopyrightfalse
\DeclareOption{copyright}{\THESISOPTIONcopyrighttrue}

% Load basic options
\ProcessOptions
\ProcessPgfOptions{/thesis}
\LoadClass[a4paper,12pt,oneside]{book}

%-------------------------------------------------------------------------------
% Basic Packages
%-------------------------------------------------------------------------------

\usepackage[BoldFont, SlantFont, CJKchecksingle, CJKmath=true]{xeCJK}
                          % for Chinese typing
\usepackage{fontspec}     % for font selection
\usepackage{ifplatform}   % determine tex is running on which platform/OS
\usepackage{indentfirst}  % indention (Windows need this package)
\usepackage{setspace}     % for \doublespacing & \begin{spacing}
\usepackage{tikz}         % for watermark position configuration
\usepackage{eso-pic}      % for watermark
\usepackage[xetex, hidelinks]{hyperref}  % for index
\usepackage{geometry}     % page margin setting
\usepackage{emptypage}    % clear page number in empty even pages
\usepackage{afterpage}    % adding blank page after cover & title page (twoside)
\usepackage{lipsum}       % generating text for testing
\usepackage{verbatim}     % for \comment command
\usepackage[retainorgcmds]{IEEEtrantools}  % for \bstctlcite
\usepackage{xCJKnumb}     % coverting arabic number to chinese number
\usepackage{titlesec}     % formating titles of sectioning
\usepackage{titletoc}     % formating titles in toc
\usepackage{tocloft}	  % centering toc, lof, and lot
\usepackage{caption}	  % for subfigure
\usepackage[labelformat=simple]{subcaption} % for subfigure
\usepackage[chapter]{algorithm}  % formating the numbering of algorithm label

%-------------------------------------------------------------------------------
% Page Format
%-------------------------------------------------------------------------------

% Page margin
\ifTHESISOPTIONbinding  % only valid in final mode
  \geometry{left=3 cm, right=2 cm, top=2.5 cm, bottom=2.5 cm}%
\else
  \geometry{left=2.5 cm, right=2.5 cm, top=2.5 cm, bottom=2.5 cm}%
\fi

% Position of page number
\pagestyle{plain}
\setlength{\footskip}{1.5cm}

% Double spacing
\doublespacing

%-------------------------------------------------------------------------------
% English Font Setting
%-------------------------------------------------------------------------------

% Main font for English
\newcommand{\mainfont}[1]{%
\ifx&#1&%
  \setmainfont[Ligatures=TeX]{Times New Roman}
\else
  \setmainfont[Ligatures=TeX]{#1}
\fi
}

% Sans-serif font for English
\newcommand{\sansfont}[1]{%
\ifx&#1&%
  \setsansfont[Ligatures=TeX]{Arial}
\else
  \setsansfont[Ligatures=TeX]{#1}
\fi
}

%-------------------------------------------------------------------------------
% Chinese Font Setting
%-------------------------------------------------------------------------------

% Main (serif) font for Chinese
\newcommand{\mainfontzh}[1]{%
\ifx&#1&%
  \ifwindows  % Windows
    \setCJKmainfont{DFKai-SB}  % 標楷體
  \else\iflinux  % Linux
    \setCJKmainfont{AR PL UKai TW}  % AR PL 中楷
  \else\ifmacosx  % Mac OS X
    \setCJKmainfont{Kaiti TC Regular}  % 楷體-繁
  \else  % '-shell-escape' is not set, using Windows fonts as default
    \setCJKmainfont{DFKai-SB}
  \fi\fi\fi
\else
  \setCJKmainfont{#1}
\fi
}

% Sans-serif font for Chinese
\newcommand{\sansfontzh}[1]{%
\ifx&#1&%
  \ifwindows  % Windows
    \setCJKsansfont{PMingLiU}  % 新細明體
  \else\iflinux  % Linux
    \setCJKsansfont{AR PL UMing TW}  % AR PL 明體
  \else\ifmacosx  % Mac OS X
    \setCJKsansfont{LiSong Pro}  % 儷宋 Pro (明體)
  \else  % '-shell-escape' is not set, using Windows fonts as default
    \setCJKsansfont{PMingLiU}
  \fi\fi\fi
\else
  \setCJKsansfont{#1}
\fi
}

% Enable line break for chinese
\XeTeXlinebreaklocale "zh"
\XeTeXlinebreakskip = 0pt plus 1pt

%-------------------------------------------------------------------------------
% Macros
%-------------------------------------------------------------------------------

% Chinese title of the thesis/dissertation
\def\titlezh#1{\gdef\@titlezh{#1}}

% The year and month the completed thesis is submitted in English
\def\degreeyear#1{\gdef\@degreeyear{#1}}
\def\degreemonth#1{\gdef\@degreemonth{#1}}

% The year and month the completed thesis is submitted in Chinese
\def\degreeyearzh#1{\gdef\@degreeyearzh{#1}}

% The full (unabbreviated) name of the degree
\def\degree#1{\gdef\@degree{#1}}

% The name of your degree's field (e.g. Psychology, Computer Science)
\def\field#1{\gdef\@field{#1}}
\def\awarded#1{\gdef\@awarded{#1}}

% The type of thesis in English
\def\thesistype#1{\gdef\@thesistype{#1}}

% The type of thesis in Chinese
\def\thesistypezh#1{\gdef\@thesistypezh{#1}}

% The name of the institute in English
\def\institute#1{\gdef\@institute{#1}}

% The name of the institute in Chinese
\def\institutezh#1{\gdef\@institutezh{#1}}

% The name of college in English
\def\college#1{\gdef\@college{#1}}

% The name of university in English
\def\university#1{\gdef\@university{#1}}

% The name of university in Chinese
\def\universityzh#1{\gdef\@universityzh{#1}}

% The location of university
\def\location#1{\gdef\@location{#1}}

% The name of advisor in English
\def\advisorFN#1{\gdef\@advisorFN{#1}}
\def\advisorLN#1{\gdef\@advisorLN{#1}}

% The title of advisor in English
\def\advisorTitle#1{\gdef\@advisorTitle{#1}}

% The name of advisor in Chinese
\def\advisorzh#1{\gdef\@advisorzh{#1}}

% The title of advisor in Chinese
\def\advisorTitlezh#1{\gdef\@advisorTitlezh{#1}}

% The name of co-advisor A in English
\def\coadvisorAFN#1{\gdef\@coadvisorAFN{#1}}
\def\coadvisorALN#1{\gdef\@coadvisorALN{#1}}

% The title of advisor A in English
\def\coadvisorATitle#1{\gdef\@coadvisorATitle{#1}}

% The name of co-advisor A in Chinese
\def\coadvisorAzh#1{\gdef\@coadvisorAzh{#1}}

% The title of advisor A in Chinese
\def\coadvisorATitlezh#1{\gdef\@coadvisorATitlezh{#1}}

% The name of co-advisor B in English
\def\coadvisorBFN#1{\gdef\@coadvisorBFN{#1}}
\def\coadvisorBLN#1{\gdef\@coadvisorBLN{#1}}

% The title of advisor B in English
\def\coadvisorBTitle#1{\gdef\@coadvisorBTitle{#1}}

% The name of co-advisor B in Chinese
\def\coadvisorBzh#1{\gdef\@coadvisorBzh{#1}}

% The title of advisor B in Chinese
\def\coadvisorBTitlezh#1{\gdef\@coadvisorBTitlezh{#1}}

% The name of the author in English
\def\authorFN#1{\gdef\@authorFN{#1}}
\def\authorLN#1{\gdef\@authorLN{#1}}

% The name of the author in Chinese
\def\authorzh#1{\gdef\@authorzh{#1}}

% The path to watermark
\def\watermark#1{\gdef\@watermark{#1}}

% Title of Acknowledgement
\def\acktitle#1{\gdef\@acktitle{#1}}

% Title of Table of Contents
\def\toctitle#1{\gdef\@toctitle{#1}}

% Title of List of Figures
\def\loftitle#1{\gdef\@loftitle{#1}}

% Title of List of Tables
\def\lottitle#1{\gdef\@lottitle{#1}}

% Title of List of Bibliography
\def\bibtitle#1{\gdef\@bibtitle{#1}}

% Title of Curriculum Vitae
\def\cvtitle#1{\gdef\@cvtitle{#1}}

% Title of List of Publications
\def\loptitle#1{\gdef\@loptitle{#1}}

% Number of frontpages reserved for 授權書 and 審定書
\def\reservedpagess#1{\gdef\@reservedfrontpages{#1}}

%-------------------------------------------------------------------------------
% Default Values for Macros
%-------------------------------------------------------------------------------

% Define macros related to degree
\ifTHESISOPTIONmaster
  \thesistype{Thesis}%
  \thesistypezh{碩士論文}%
  \degree{Master}%
  \reservedpagess{2}% 授權書 + 中文審定書
\else
  \thesistype{Dissertation}%
  \thesistypezh{博士論文}%
  \degree{Doctor of Philosophy}%
  \reservedpagess{3}% 授權書 + 中文審定書 + 英文審定書
\fi

% Define language-related macros for front pages and back pages
\ifTHESISOPTIONzh
  \acktitle{誌謝}%
  \toctitle{目錄}%
  \loftitle{圖目錄}%
  \lottitle{表目錄}%
  \bibtitle{參考文獻}%
  \cvtitle{自傳}%
  \loptitle{著作目錄}%
\else
  \acktitle{Acknowledgement}%
  \toctitle{Table of Contents}%
  \loftitle{List of Figures}%
  \lottitle{List of Tables}%
  \ifTHESISOPTIONmaster
    \bibtitle{References}%
  \else
    \bibtitle{Bibliography}%
  \fi
  \cvtitle{Curriculum Vitae}%
  \loptitle{List of Publications}%
\fi

%-------------------------------------------------------------------------------
% Table of Contents, List of Figures, and List of Tables
%-------------------------------------------------------------------------------

% Place the titles of ToC, LoF, and LoT to center and set the font of the titles
\renewcommand{\cfttoctitlefont}{\hspace*{\fill}\Huge\bfseries}
\renewcommand{\cftaftertoctitle}{\hspace*{\fill}}
\renewcommand{\cftlottitlefont}{\hspace*{\fill}\Huge\bfseries}
\renewcommand{\cftafterlottitle}{\hspace*{\fill}}
\renewcommand{\cftloftitlefont}{\hspace*{\fill}\Huge\bfseries}
\renewcommand{\cftafterloftitle}{\hspace*{\fill}}

% Set the language used in ToC, LoF, and LoT
\ifTHESISOPTIONzh
  \renewcommand{\contentsname}{\makebox[3em][s]{\@toctitle}}%
  \renewcommand{\listfigurename}{\makebox[4em][s]{\@loftitle}}%
  \renewcommand{\listtablename}{\makebox[4em][s]{\@lottitle}}%
  \renewcommand{\tablename}{表}%
  \renewcommand{\figurename}{圖}%
  \renewcommand{\cftfigpresnum}{圖~}%
  \setlength{\cftfignumwidth}{4em}%
  \renewcommand{\cfttabpresnum}{表~}%
  \setlength{\cfttabnumwidth}{4em}%
\else
  \renewcommand{\contentsname}{\@toctitle}%
  \renewcommand{\listfigurename}{\@loftitle}%
  \renewcommand{\listtablename}{\@lottitle}%
\fi

% Set the chapter numbering to Chinese number in ToC
\ifTHESISOPTIONzh
  \titlecontents{chapter}[0pt]{}%
  {\bfseries 第\xCJKnumber{\thecontentslabel}章\hspace{0.5em}}{}%
  {\cftdotfill{\cftdotsep}\contentspage}%
\else
% Format the chapter numbering in ToC when using English
  \titlecontents{chapter}[0pt]{}%
  % Fix the chapter number within a box no matter it has 1 or 2 digits
  {\bfseries \makebox[1em][l]{\thecontentslabel}\hspace{0.25em}}{}%
  {\cftdotfill{\cftdotsep}\contentspage}%
\fi

% Adjust the position of the title of ToC, LoF, and LoT
\renewcommand\cftbeforetoctitleskip{-0.5cm}
\renewcommand\cftbeforeloftitleskip{-0.5cm}
\renewcommand\cftbeforelottitleskip{-0.5cm}

% A wraper to generate toc, lof, and lot
\def\maketocs{%
\ifTHESISOPTIONreview\else
% Table of Contents
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{\textbf{\@toctitle}}%
  \tableofcontents
% List of Figures
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{\textbf{\@loftitle}}%
  \listoffigures
% List of Tables
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{\textbf{\@lottitle}}%
  \listoftables
\fi
}

%-------------------------------------------------------------------------------
% Chapters
%-------------------------------------------------------------------------------

% Set the position of chapter label and title
\ifTHESISOPTIONzh
  \titleformat{\chapter}[block]% (place label and title body at the same line)
  {\centering\Huge\bfseries}%
  {\xCJKnumber{\thechapter}、\hspace{0.5em}}% (X、 ...)
  {0em}{}%
\else
  \titleformat{\chapter}[display]% (title body is placed at second line)
  {\centering\Huge\bfseries}%
  {\chaptertitlename\ \thechapter}%
  {0em}{}%
% The following is the original chapter title format and label numbering style
% suggested by NCTU Thesis Format. But, such an English chapter title format is
% too ugly. Not mentioning that I need to number chapter label in Roman style,
% but use arabic style in section label, i.e. doing something like this:
%     (chapter) II. Related Work
%     (section)     2.1 brabra
% Besides, generally, Roman style numbering is reserved for 'parts' in a book.
% Therefore, I made my own way. :)
%
%  \titleformat{\chapter}[block]% (place label and title body at the same line)
%  {\centering\Huge\bfseries}%
%  {\Roman{chapter}.\hspace{0.5em}}%
%  {0em}{}%
\fi

% Set the spacing before and after chapter label/title
%   {type}{left}{before seperation}{after seperation}
\titlespacing*{\chapter}{0em}{-40pt}{*6}

%-------------------------------------------------------------------------------
% Watermark
%-------------------------------------------------------------------------------

% Set the source of watermark
\newcommand\BackgroundPicture{%
\ifTHESISOPTIONwatermark
% for draft mode: print "DRAFT"
  \ifTHESISOPTIONdraft
    \setlength{\@tempdimb}{.5\paperwidth}%
    \setlength{\@tempdimc}{.5\paperheight}%
    \setlength{\unitlength}{1pt}%
    \put(\strip@pt\@tempdimb,\strip@pt\@tempdimc){%
    \makebox(0,0){\rotatebox{45}{\textcolor[gray]{0.75}%
      {\fontsize{6cm}{6cm}\selectfont{DRAFT}}}}%
    }%
  \fi
% for final mode: print the watermark specified by \watermark{}
  \ifTHESISOPTIONfinal
    \begin{tikzpicture}%
      \node[minimum width=\paperwidth,minimum height=\paperheight,opacity=0.75]%
        {\includegraphics[width=0.75\textwidth]{\@watermark}};%
    \end{tikzpicture}%
  \fi
\fi
}

% Update \cleardoublepage to handle watermark
%
%   \chapter{} implicity calls \cleardoublepage first, then starts to print
% chapter title and contents
\let\oldcleardoublepage\cleardoublepage
\renewcommand{\cleardoublepage}{%
  % Remove watermark if previous page is a blank even page in twoside mode.
  \newpage
  \ClearShipoutPicture
  \oldcleardoublepage
  % Add watermark
  \AddToShipoutPicture{\BackgroundPicture}%
}

%-------------------------------------------------------------------------------
% Commands
%-------------------------------------------------------------------------------

% Change to uppercase of roman number
\newcommand{\RNum}[1]{\uppercase\expandafter{\romannumeral #1\relax}}

% Change margin of a period
%% \changemargin
\def\changemargin#1#2{\list{}{\rightmargin#2\leftmargin#1}\item[]}
%% \endchangemargin
\let\endchangemargin=\endlist

% Covert 'A' to 1, 'B' to 2, ...
%TODO
%   This is a workaround to show '附錄一' in the chapter label but 'A.1' in the
% section label of an appendix, rather than showing '1.1', which conflicts with
% the section label of a regular chapter. Hope someone can fix this in a smarter
% way.
\DeclareRobustCommand{\xCJKalphatozhnum}[1]{%
  \ifnum\strcmp{#1}{A} = 0 一 \else
  \ifnum\strcmp{#1}{B} = 0 二 \else
  \ifnum\strcmp{#1}{C} = 0 三 \else
  \ifnum\strcmp{#1}{D} = 0 四 \else
  \ifnum\strcmp{#1}{E} = 0 五 \else
  \ifnum\strcmp{#1}{F} = 0 六 \else
  \ifnum\strcmp{#1}{G} = 0 七 \else
  \ifnum\strcmp{#1}{H} = 0 八 \else
  \ifnum\strcmp{#1}{I} = 0 九 \else
  \ifnum\strcmp{#1}{J} = 0 十 \else
  \ifnum\strcmp{#1}{K} = 0 十一 \else
  \ifnum\strcmp{#1}{L} = 0 十二 \else
  \ifnum\strcmp{#1}{M} = 0 十三 \else
  \ifnum\strcmp{#1}{N} = 0 十四 \else
  \ifnum\strcmp{#1}{O} = 0 十五 \else
  \ifnum\strcmp{#1}{P} = 0 十六 \else
  \ifnum\strcmp{#1}{Q} = 0 十七 \else
  \ifnum\strcmp{#1}{R} = 0 十八 \else
  \ifnum\strcmp{#1}{S} = 0 十九 \else
  \ifnum\strcmp{#1}{T} = 0 二十 \else 零%
  \fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi
}

% Keyword under abstract
\newcommand{\keywordszh}[1]{\vfill\textbf{\textit{關鍵字: }} #1}
\newcommand{\keywordsen}[1]{\vfill\textbf{\textit{Keywords: }} #1}

%-------------------------------------------------------------------------------
% Bibliography
%-------------------------------------------------------------------------------

% A wraper to add Bibliography to "Table of Contents"
\newcommand{\addBibToContents}{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{\textbf{\@bibtitle}}%
}

% Configure the name of References/Bibliography
\renewcommand{\bibname}{\makebox[5.5em][s]{\@bibtitle}}

%-------------------------------------------------------------------------------
% Algortithms
%-------------------------------------------------------------------------------

% Change the numbering style of algorithms to [chapter].[algorithm]
%   Note that: you need to use \caption before \label
\renewcommand{\thealgorithm}{\arabic{chapter}.\arabic{algorithm}}

%-------------------------------------------------------------------------------
% Appendicies
%-------------------------------------------------------------------------------

% A wraper to reset the style of appendicies when 'zh' option is set
\newcommand{\addAppxToContents}{%
% Hide section, subsection from ToC
\addtocontents{toc}{\protect\setcounter{tocdepth}{0}}
\ifTHESISOPTIONzh
  % Set appendix numbering to Chiese style in ToC
  \titlecontents{chapter}[0pt]{}%
  {\bfseries 附錄\xCJKalphatozhnum{\thecontentslabel}\quad}%
  {}{\cftdotfill{\cftdotsep}\contentspage}%

  % Set appendix title to Chinese style
  \titleformat{\chapter}[block]% (place label and title body at the same line)
  {\centering\Huge\bfseries}%
  {附錄\xCJKalphatozhnum{\thechapter}\quad}% (X、 ...)
  {0em}{}%
\else
  % Format appendix title shown in ToC
  \titlecontents{chapter}[0pt]{}%
  {\bfseries \appendixname\hspace{0.5em}\thecontentslabel\hspace{0.5em}}%
  {}{\cftdotfill{\cftdotsep}\contentspage}%
\fi
}

%-------------------------------------------------------------------------------
% Figures
%-------------------------------------------------------------------------------

% Changing the format of subcaption for reference
\renewcommand\thesubfigure{ (\alph{subfigure})}

%-------------------------------------------------------------------------------
% Cover Page
%-------------------------------------------------------------------------------

\def\coverpage{
  \thispagestyle{empty}%
  % University, institute, and title
  \begin{center}
    % University
    \begingroup
      \onehalfspacing
      \fontsize{18}{18}\selectfont
      % University
      \@universityzh\\
      % Institute
      \@institutezh\\
    \endgroup
    \begin{spacing}{1.5}
      % Thesis type in chinese
      \begingroup
        \fontsize{18}{18}\selectfont
        \@thesistypezh\\
        \ifTHESISOPTIONdraft
          初稿\\
        \fi
      \endgroup
      \vspace{\baselineskip}
      % Institue name in English
      \begingroup
        \fontsize{14}{14}\selectfont
        \@institute\\
      \endgroup
      % University and thesis type in English
      \begingroup
        \fontsize{16}{16}\selectfont
        \@university\\
        \ifTHESISOPTIONmaster
          Master \@thesistype\\
        \fi
      \endgroup
      \vspace{\baselineskip}
      \vspace{\baselineskip}
      \vspace{\baselineskip}
      % Title in both of Chinese and English
      \begingroup
        \fontsize{18}{18}\selectfont
        % Chinese title
        \@titlezh\\
        % English title
        \@title\\
      \endgroup
      \vspace{\baselineskip}
      \vspace{\baselineskip}
      \vspace{\baselineskip}
      \vspace{\baselineskip}
      % Author & advisor(s)
      \begingroup
        \fontsize{18}{18}\selectfont
        \begin{tabular}{rll}
          研究生： & \@authorzh（\@authorLN, \@authorFN）\\
          指導教授： &\@advisorzh（\@advisorLN, \@advisorFN）\\
          \ifx \@coadvisorAzh \@empty \else
            & \@coadvisorAzh（\@coadvisorALN, \@coadvisorAFN）\\
          \fi
          \ifx \@coadvisorBzh \@empty \else
            & \@coadvisorBzh（\@coadvisorBLN, \@coadvisorBLN）\\
          \fi
        \end{tabular}
      \endgroup
      \vfill
      % Degree year in both of Chinese and English
      \begingroup
        \fontsize{18}{18}\selectfont
        \@degreeyearzh\\
        \@degreemonth\ \@degreeyear\\
      \endgroup
    \end{spacing}
  \end{center}
  \restoregeometry
}

%-------------------------------------------------------------------------------
% Title Page
%-------------------------------------------------------------------------------

\def\titlepage{
  \cleardoublepage
  \ClearShipoutPicture  % remove watermark in this page
  \thispagestyle{empty}
  % Chines & English titles
  \begin{center}
    \onehalfspacing
    \fontsize{18}{18}\selectfont
    \begingroup
      \@titlezh\\
      \@title\\
    \endgroup
  \end{center}
  \vspace{\baselineskip}
  % Author name and advisor name in Chinese and English
  \begin{figure}[h!]
    \centering
    \begin{subfigure}[b]{0.8\textwidth}
      \begin{flushleft}
        \singlespacing
        \setlength{\tabcolsep}{0.25em}
        % Chinese name
        \begin{tabular}{rl}%
          \large{\makebox[4em][s]{研究生}：}&\large{\@authorzh}\vspace{0.5em}\\%
          \large{指導教授：}&{\large{\@advisorzh\ 博士}}\\%
          \ifx \@coadvisorAzh \@empty \else
            &{\large{\@coadvisorAzh\ 博士}}\\%
          \fi
          \ifx \@coadvisorBzh \@empty \else
            &{\large{\@coadvisorBzh\ 博士}}\\%
          \fi
        \end{tabular}%
        \hfill
        % English name
        \begin{tabular}{rl}%
          \large{Student:}&{\large{\@authorFN\ \@authorLN}}\vspace{0.5em}\\%
          \large{Advisor:}&{\large{Dr. \@advisorFN\ \@advisorLN}}\\%
          \ifx \@coadvisorAFN \@empty \else
            &{\large{Dr. \@coadvisorAFN\ \@coadvisorALN}}\\%
          \fi
          \ifx \@coadvisorBFN \@empty \else
            &{\large{Dr. \@coadvisorBFN\ \@coadvisorBLN}}\\%
          \fi
        \end{tabular}
      \end{flushleft}
    \end{subfigure}
  \end{figure}
  \vfill
  % University & institute & thesis type in Chinese
  \begin{center}
    \begingroup
      \onehalfspacing
      \fontsize{14}{14}\selectfont
      % University
      \@universityzh\\
      % Institute
      \@institutezh\\
      % Thesis type
      \@thesistypezh\\
      \ifTHESISOPTIONdraft
        初稿\\
      \fi
    \endgroup
    \vfill
    % Submission description in English
    \begingroup
      \singlespacing
      \fontsize{14}{14}\selectfont
      \ifTHESISOPTIONdraft
        \centerline{{A \@thesistype\ Draft}}%
      \else
        \centerline{{A \@thesistype}}%
      \fi
      Submitted to {\@institute}\\
      \@college\\
      \@university\\
      in Partial Fulfilment of the Requirements\\
      for the Degree of\\
      {\@degree\ of \@field}\\
      in\\
      \@awarded\\
    \endgroup
    \vspace{\baselineskip}
    \vfill
    % Submission date and location
    {{\@degreemonth} {\@degreeyear}}\\
    \@location\\
    \vspace{0.25\baselineskip}
    %\vfill{0.25}
    \makebox[1.75\width][s]{\normalsize\@degreeyearzh}
  \end{center}
}

%-------------------------------------------------------------------------------
% Authorization Page
%-------------------------------------------------------------------------------

\def\authzpage{
  \cleardoublepage
  \ClearShipoutPicture  % remove watermark in this page
  \thispagestyle{empty}
  \phantomsection
  \null\newpage
}

%-------------------------------------------------------------------------------
% Chinese Approval Page
%-------------------------------------------------------------------------------

\def\approvalzhpage{
  \cleardoublepage
  \ClearShipoutPicture  % remove watermark in this page
  \thispagestyle{empty}
  \phantomsection
  \null\newpage
}

%-------------------------------------------------------------------------------
% English Approval Page
%-------------------------------------------------------------------------------

\def\approvalenpage{
  \cleardoublepage
  \ClearShipoutPicture  % remove watermark in this page
  \thispagestyle{empty}
  \phantomsection
  \null\newpage
}

%-------------------------------------------------------------------------------
% Copyright Page
%-------------------------------------------------------------------------------

\def\copyrightpage{
  \cleardoublepage
  \ClearShipoutPicture  % remove watermark in this page
  \thispagestyle{empty}
  \rule[0pt]{0pt}{0pt} \\
  \vspace{2.5in}
  \rule[0pt]{0pt}{0pt} \\
  \begin{center}
    \copyright {\@degreeyear} - {\@authorFN\ \@authorLN}\\
    \vspace{0.5\baselineskip}
    All rights reserved.\\
  \end{center}
}

%-------------------------------------------------------------------------------
% \maketitle Redefinition
%-------------------------------------------------------------------------------

\def\maketitle{{
\ifTHESISOPTIONreview\else
% Cover page
  \coverpage

% Title page
  \titlepage

% Authorization page
%  \authzpage

% Chinese approval page
%  \approvalzhpage

% English approval page
%  \approvalenpage

% Copyright page (shown in final mode only)
  \ifTHESISOPTIONfinal\ifTHESISOPTIONcopyright
    \copyrightpage
  \fi\fi
\fi

% Set page numbering to 'roman' (i, ii, iii, ...)
\frontmatter

% Reset page counter to zero, so that roman-style page numbering
% can start from the abstract page.
\ifTHESISOPTIONnctupagenum
\setcounter{page}{0}
\fi
}}

%-------------------------------------------------------------------------------
% Chinese Abstract
%-------------------------------------------------------------------------------

% Page layout of Chinese abstract
\def\abszhpage{
  \cleardoublepage
  % Reserve pages for 授權書 + 中/英審定書 in final mode if book-style page
  % numbering is used
  \ifTHESISOPTIONfinal\ifTHESISOPTIONbookpagenum
    \setcounter{page}{\the\numexpr\reservedpages+\arabic{page}\relax}
  \fi\fi
  \phantomsection
  \addcontentsline{toc}{chapter}{\textbf{摘要}}
  \begin{center}
    \singlespacing
% Thesis title
    {\Large \bf \@titlezh}\\
    \vspace{\baselineskip}
% Author and advisors
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}lr}%
      \setlength{\tabcolsep}{0.25em}%
  % Author
      \begin{tabular}{rl}%
        \large{學生：}&{\large{\@authorzh}}\\%
      \end{tabular}&%
      \setlength{\tabcolsep}{0.25em}%
      \begin{tabular}{rlc}%
  % Advisor
        \large{指導教授：}&{\large{\@advisorzh}}&{\large{\@advisorTitlezh}}\\%
  % Co-advisor A
        \ifx \@coadvisorAzh \@empty \else
          &{\large{\@coadvisorAzh}}&{\large{\@coadvisorATitlezh}}\\%
        \fi
  % Co-advisor B
        \ifx \@coadvisorBzh \@empty \else
          &{\large{\@coadvisorBzh}}&{\large{\@coadvisorBTitlezh}}\\%
        \fi
      \end{tabular}\\%
    \end{tabular*}\\
% Institute and university name
    \vspace{0.5\baselineskip}
    \large{\@universityzh\hspace{1ex}\@institutezh}\\
    \vspace{\baselineskip}
% Abstract title
    \Large{\textbf{摘\qquad 要}}\\
  \end{center}
}

% New environment for Chinese Abstract
\newenvironment{abstractzh}{%
  \ifTHESISOPTIONreview\else
    \abszhpage
    \par % start a new paragraph and force the first line being indented
  \fi
  \ifTHESISOPTIONreview\comment\fi  % ignore input tex in review mode
}{%
  \ifTHESISOPTIONreview\endcomment\fi
}

%-------------------------------------------------------------------------------
% English Abstract
%-------------------------------------------------------------------------------

% Page layout of English abstract
\def\absenpage
{
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{\textbf{Abstract}}
  \begin{center}
    \singlespacing
% Thesis title
    {\Large \bf \@title}\\
    \vspace{\baselineskip}
% Author and advisors
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}lr}%
      \setlength{\tabcolsep}{0.25em}%
  % Author
      \begin{tabular}{rl}%
        \large{Student:}&{\large{\@authorFN\ \@authorLN}}\\%
      \end{tabular}&%
      \setlength{\tabcolsep}{0.25em}%
      \begin{tabular}{rl}%
  % Advisor
        \large{Advisor:}&{\large{\@advisorTitle\ \@advisorFN\ \@advisorLN}}\\%
  % Co-advisor A
        \ifx \@coadvisorAFN \@empty \else
          &{\large{\@coadvisorATitle\ \@coadvisorAFN\ \@coadvisorALN}}\\%
        \fi
  % Co-advisor B
        \ifx \@coadvisorBFN \@empty \else
          &{\large{\@coadvisorBTitle\ \@coadvisorBFN\ \@coadvisorBLN}}\\%
        \fi
      \end{tabular}\\%
    \end{tabular*}\\
% Institue and university name
    \vspace{0.5\baselineskip}
    \large{\@institute}\\
    \large{\@university}\\
    \vspace{\baselineskip}
% Abstract title
    \Large{\textbf{Abstract}}\\
  \end{center}
}

% New environment for English abstract
\newenvironment{abstract}{%
  \ifTHESISOPTIONreview\else
    \absenpage
    \par % start a new paragraph and force the first line being indented
  \fi
  \ifTHESISOPTIONreview\comment\fi  % ignore input tex in review mode
}{%
  \ifTHESISOPTIONreview\endcomment\fi
}

%-------------------------------------------------------------------------------
% Acknowledgement Page
%-------------------------------------------------------------------------------

\def\ackpage
{
  \cleardoublepage
  \ClearShipoutPicture  % remove watermark in this page
  %\phantomsection
  %\addcontentsline{toc}{chapter}{\textbf{\@acktitle}}
  \begin{center}
    \ifTHESISOPTIONzh
      {\LARGE \bf \makebox[3em][s]{\@acktitle}}\\
    \else
      {\LARGE \bf \@acktitle}\\
    \fi
  \end{center}
}

\newenvironment{acknowledgement}{%
  \ifTHESISOPTIONfinal
    \ackpage
    \par % start a new paragraph and force the first line being indented
  \fi
  \ifTHESISOPTIONfinal\else\comment\fi  % ignore input tex if not in final mode
}{%
  \ifTHESISOPTIONfinal\else\endcomment\fi
}

%-------------------------------------------------------------------------------
% Deidication Page
%-------------------------------------------------------------------------------

\newenvironment{dedication}{%
  \ifTHESISOPTIONfinal\ifTHESISOPTIONphd
    \cleardoublepage
    \ClearShipoutPicture  % remove watermark in this page
    \thispagestyle{empty}%
    \vspace*{6.6cm}
    \begin{center}
  \fi\fi
  % ignore input tex if not in the final mode of a PhD dissertation
  \ifTHESISOPTIONfinal\ifTHESISOPTIONphd\else\comment\fi\else\comment\fi
}{%
  \ifTHESISOPTIONfinal\ifTHESISOPTIONphd\else\endcomment\fi\else\endcomment\fi
  \ifTHESISOPTIONfinal\ifTHESISOPTIONphd
    \end{center}
  \fi\fi
}

%-------------------------------------------------------------------------------
% Curriculum Vitae Page
%-------------------------------------------------------------------------------

\newenvironment{vita}{%
  % Only be compiled in the draft or final mode of a PhD dissertation
  \ifTHESISOPTIONreview\comment\else\ifTHESISOPTIONphd\else\comment\fi\fi
    \cleardoublepage
    \phantomsection
    \addcontentsline{toc}{chapter}{\textbf{\@cvtitle}}
    \ifTHESISOPTIONzh
      \chapter*{\makebox[3em][s]{\@cvtitle}}
    \else
      \chapter*{\@cvtitle}
    \fi
}{%
  \ifTHESISOPTIONreview\endcomment\else\ifTHESISOPTIONphd\else\endcomment\fi\fi
}

%-------------------------------------------------------------------------------
% Publications Page
%-------------------------------------------------------------------------------

\newenvironment{publications}{%
  % Only be compiled in the draft or final mode of a PhD dissertation
  \ifTHESISOPTIONreview\comment\else\ifTHESISOPTIONphd\else\comment\fi\fi
    \cleardoublepage
    \phantomsection
    \addcontentsline{toc}{chapter}{\textbf{\@loptitle}}
    \ifTHESISOPTIONzh
      \chapter*{\makebox[5.5em][s]{\@loptitle}}
    \else
      \chapter*{\@loptitle}
    \fi
}{%
  \ifTHESISOPTIONreview\endcomment\else\ifTHESISOPTIONphd\else\endcomment\fi\fi
}

\endinput
