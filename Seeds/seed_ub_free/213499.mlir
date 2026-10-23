module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<48> : tensor<8x7x1xi16>}> : () -> tensor<8x7x1xi16>
    %1 = "tosa.const"() <{values = dense<-183> : tensor<8x7x1xi16>}> : () -> tensor<8x7x1xi16>
    %2 = tosa.bitwise_and %0, %1 : (tensor<8x7x1xi16>, tensor<8x7x1xi16>) -> tensor<8x7x1xi16>
    %3 = tosa.clamp %2 {max_val = 10 : i16, min_val = -61 : i16} : (tensor<8x7x1xi16>) -> tensor<8x7x1xi16>
    %cast = tensor.cast %3 : tensor<8x7x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

