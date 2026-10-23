module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-135> : tensor<1x9x6xi16>}> : () -> tensor<1x9x6xi16>
    %1 = tosa.reverse %0 {axis = 0 : i32} : (tensor<1x9x6xi16>) -> tensor<1x9x6xi16>
    %2 = tosa.clamp %1 {max_val = 124 : i16, min_val = 26 : i16} : (tensor<1x9x6xi16>) -> tensor<1x9x6xi16>
    %cast = tensor.cast %2 : tensor<1x9x6xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

