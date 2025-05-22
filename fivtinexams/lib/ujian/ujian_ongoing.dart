import 'package:flutter/material.dart';

class UjianOngoingPage extends StatefulWidget {
  const UjianOngoingPage({super.key});

  @override
  State<UjianOngoingPage> createState() => _UjianPageState();
}

class _UjianPageState extends State<UjianOngoingPage> with TickerProviderStateMixin {
  final List<ExamQuestion> _questions = [
    ExamQuestion(
      id: 1,
      question: "Siapakah presiden pertama Indonesia?",
      options: [
        "A. Soekarno",
        "B. Soeharto",
        "C. Joget oke gas dulu baru ku kasih.",
        "D. すみません",
      ],
      isAnswered: false,
      selectedOption: -1,
    ),
    ExamQuestion(
      id: 2,
      question: "Mengapa Bumi itu bulat?",
      options: [
        "A. Karena ciptaan tuhan.",
        "B. Kalau datar kenapa gaada farland.",
        "C. Yaa ndak tau kok tanya saya.",
        "D. Pak Prabowo.",
      ],
      isAnswered: false,
      selectedOption: -1,
    ),
    ExamQuestion(
      id: 3,
      question: "Ibukota negara Indonesia adalah...",
      options: [
        "A. Jakarta",
        "B. Bandung",
        "C. Surabaya",
        "D. Yogyakarta",
      ],
      isAnswered: false,
      selectedOption: -1,
    ),
    ExamQuestion(
      id: 4,
      question: "Berapa hasil dari 5 x 5?",
      options: [
        "A. 10",
        "B. 15",
        "C. 25",
        "D. 30",
      ],
      isAnswered: false,
      selectedOption: -1,
    ),
    ExamQuestion(
      id: 5,
      question: "Planet terbesar di tata surya adalah...",
      options: [
        "A. Bumi",
        "B. Mars",
        "C. Jupiter",
        "D. Saturnus",
      ],
      isAnswered: false,
      selectedOption: -1,
    ),
  ];

  int _timeRemaining = 30; // 30 detik untuk testing
  bool _isTimeUpDialogShown = false;
  bool _isConfirmationDialogShown = false;
  bool _isExamExpired = false;
  
  // Controllers untuk animasi
  late Map<int, AnimationController> _animationControllers;
  late Map<int, Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startTimer();
  }

  void _initAnimations() {
    _animationControllers = {};
    _animations = {};
    
    for (var question in _questions) {
      _animationControllers[question.id] = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
      
      _animations[question.id] = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _animationControllers[question.id]!,
          curve: Curves.easeInOut,
        ),
      );
    }
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (_timeRemaining > 0) {
            _timeRemaining--;
            _startTimer();
          } else if (!_isTimeUpDialogShown) {
            _isTimeUpDialogShown = true;
            _isExamExpired = true;
            _showTimeUpDialog();
          }
        });
      }
    });
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Waktu Ujian Habis"),
        content: const Text(
          "Waktu ujian telah habis. Silakan klik tombol 'Kirim' di bawah untuk mengumpulkan jawaban Anda.",
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF257180),
              foregroundColor: Colors.white,
            ),
            child: const Text("Mengerti"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Membersihkan animation controllers
    for (var controller in _animationControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _buildExamHeader(),
              Expanded(
                child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: _buildQuestionArea(),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExamHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "IPAS",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              if (_isExamExpired)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "Waktu Habis",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800],
                    ),
                  ),
                ),
              Text(
                _formatTime(_timeRemaining),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _isExamExpired ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionArea() {
    bool allQuestionsAnswered = _questions.every((question) => question.isAnswered);
    
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ..._questions.map((question) => Column(
          children: [
            _buildQuestionCard(question),
            const SizedBox(height: 16),
          ],
        )),
        
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            children: [
              if (!allQuestionsAnswered && _timeRemaining > 0)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    "Anda harus menjawab semua soal sebelum mengumpulkan ujian.",
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _timeRemaining > 0 
                    ? (allQuestionsAnswered ? () => _showConfirmationDialog() : null)
                    : () => _showConfirmationDialog(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _timeRemaining > 0 
                      ? const Color(0xFFE07A5F) 
                      : const Color(0xFF257180),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[400],
                  ),
                  child: Text(
                    _timeRemaining > 0 ? "Kirim" : "Waktu Habis - Kirim Sekarang",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(ExamQuestion question) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 16, 60, 16),
                child: Text(
                  "${question.id}. ${question.question}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: AnimatedBuilder(
                  animation: _animations[question.id]!,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: question.isAnswered ? 
                        1.0 + (_animations[question.id]!.value * 0.3) : 1.0,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: question.isAnswered 
                              ? const Color(0xFF257180)
                              : const Color(0xFFCB6040),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Icon(
                            question.isAnswered 
                              ? Icons.check 
                              : Icons.priority_high,
                            color: question.isAnswered 
                              ? const Color(0xFF257180)
                              : const Color(0xFFCB6040),
                            size: 16,
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
          
          Divider(
            height: 1,
            thickness: 0.8,
            color: Colors.grey[200],
          ),
          
          ...question.options.asMap().entries.map((entry) {
            int index = entry.key;
            String option = entry.value;
            return RadioListTile<int>(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              title: Text(
                option,
                style: TextStyle(
                  fontSize: 15,
                  color: _isExamExpired ? Colors.grey : Colors.grey[800],
                ),
              ),
              value: index,
              groupValue: question.selectedOption,
              onChanged: _isExamExpired 
                ? null // Menonaktifkan interaksi jika waktu sudah habis
                : (value) {
                    setState(() {
                      if (!question.isAnswered) {
                        // Memulai animasi hanya jika status berubah dari belum ke sudah dijawab
                        _animationControllers[question.id]!.reset();
                        _animationControllers[question.id]!.forward();
                      }
                      
                      question.selectedOption = value!;
                      question.isAnswered = true;
                    });
                  },
              activeColor: const Color(0xFF257180),
              visualDensity: VisualDensity.compact,
            );
          }),
        ],
      ),
    );
  }

  void _showConfirmationDialog() {
    if (_isConfirmationDialogShown) return;
    
    setState(() {
      _isConfirmationDialogShown = true;
    });
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi Pengumpulan"),
        content: Text(
          _timeRemaining > 0
            ? "Apakah Anda yakin ingin mengumpulkan ujian ini? Anda tidak dapat kembali mengerjakan ujian ini setelah dikumpulkan."
            : "Waktu ujian telah habis. Apakah Anda yakin ingin mengumpulkan jawaban sekarang?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isConfirmationDialogShown = false;
              });
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A7C8E),
              foregroundColor: Colors.white,
            ),
            child: const Text("Ya, Kumpulkan"),
          ),
        ],
      ),
    ).then((_) {
      setState(() {
        _isConfirmationDialogShown = false;
      });
    });
  }

  void _showSuccessDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text("Ujian Berhasil Dikumpulkan"),
      content: const Text(
        "Terima kasih telah menyelesaikan ujian ini. Hasil ujian Anda akan segera diproses.",
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Tutup dialog
            Navigator.pop(context); // Kembali ke UjianPage
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2A7C8E),
            foregroundColor: Colors.white,
          ),
          child: const Text("Kembali ke Ujian"),
        ),
      ],
    ),
  );
}

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;
    
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }
}

class ExamQuestion {
  final int id;
  final String question;
  final List<String> options;
  bool isAnswered;
  int selectedOption;
  
  ExamQuestion({
    required this.id,
    required this.question,
    required this.options,
    this.isAnswered = false,
    this.selectedOption = -1,
  });
}