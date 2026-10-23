module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-79> : tensor<6xi16>}> : () -> tensor<6xi16>
    %1 = tosa.clamp %0 {max_val = -15 : i16, min_val = -20 : i16} : (tensor<6xi16>) -> tensor<6xi16>
    %cast = tensor.cast %1 : tensor<6xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

