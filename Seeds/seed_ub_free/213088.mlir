module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.163500e+02> : tensor<7x10x6x5xf32>}> : () -> tensor<7x10x6x5xf32>
    %1 = "tosa.const"() <{values = dense<173> : tensor<9xi16>}> : () -> tensor<9xi16>
    %2 = tosa.ceil %0 : (tensor<7x10x6x5xf32>) -> tensor<7x10x6x5xf32>
    %3 = tosa.sub %2, %2 : (tensor<7x10x6x5xf32>, tensor<7x10x6x5xf32>) -> tensor<7x10x6x5xf32>
    %4 = tosa.concat %3, %3 {axis = 1 : i32} : (tensor<7x10x6x5xf32>, tensor<7x10x6x5xf32>) -> tensor<7x20x6x5xf32>
    %5 = tosa.sub %4, %4 : (tensor<7x20x6x5xf32>, tensor<7x20x6x5xf32>) -> tensor<7x20x6x5xf32>
    %6 = tosa.bitwise_not %1 : (tensor<9xi16>) -> tensor<9xi16>
    %cast = tensor.cast %5 : tensor<7x20x6x5xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<9xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

