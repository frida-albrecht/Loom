module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<136> : tensor<7x5x6x2xi16>}> : () -> tensor<7x5x6x2xi16>
    %1 = tosa.bitwise_not %0 : (tensor<7x5x6x2xi16>) -> tensor<7x5x6x2xi16>
    %2 = tosa.reduce_sum %1 {axis = 1 : i32} : (tensor<7x5x6x2xi16>) -> tensor<7x1x6x2xi16>
    %cast = tensor.cast %2 : tensor<7x1x6x2xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

