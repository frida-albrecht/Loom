module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<9x1xi16>}> : () -> tensor<9x1xi16>
    %1 = tosa.clamp %0 {max_val = 9 : i16, min_val = -15 : i16} : (tensor<9x1xi16>) -> tensor<9x1xi16>
    %cast = tensor.cast %1 : tensor<9x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

