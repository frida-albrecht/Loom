module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<138> : tensor<1x1x5x1xi16>}> : () -> tensor<1x1x5x1xi16>
    %1 = tosa.reduce_product %0 {axis = 1 : i32} : (tensor<1x1x5x1xi16>) -> tensor<1x1x5x1xi16>
    %2 = tosa.reverse %1 {axis = 0 : i32} : (tensor<1x1x5x1xi16>) -> tensor<1x1x5x1xi16>
    %cast = tensor.cast %2 : tensor<1x1x5x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

