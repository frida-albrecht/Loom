module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-60> : tensor<9x7x3xi16>}> : () -> tensor<9x7x3xi16>
    %1 = tosa.clamp %0 {max_val = -7 : i16, min_val = -43 : i16} : (tensor<9x7x3xi16>) -> tensor<9x7x3xi16>
    %2 = tosa.reduce_min %1 {axis = 1 : i32} : (tensor<9x7x3xi16>) -> tensor<9x1x3xi16>
    %3 = tosa.reduce_product %2 {axis = 2 : i32} : (tensor<9x1x3xi16>) -> tensor<9x1x1xi16>
    %cast = tensor.cast %3 : tensor<9x1x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

