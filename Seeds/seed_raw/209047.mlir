module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-92> : tensor<9x9xi16>}> : () -> tensor<9x9xi16>
    %1 = tosa.reduce_min %0 {axis = 1 : i32} : (tensor<9x9xi16>) -> tensor<9x1xi16>
    %2 = tosa.clamp %1 {max_val = 101 : i16, min_val = 24 : i16} : (tensor<9x1xi16>) -> tensor<9x1xi16>
    %cast = tensor.cast %2 : tensor<9x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

