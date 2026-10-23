module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.551800e+02> : tensor<1x9x7x10xf32>}> : () -> tensor<1x9x7x10xf32>
    %1 = "tosa.const"() <{values = dense<138> : tensor<6x4xi16>}> : () -> tensor<6x4xi16>
    %2 = "tosa.const"() <{values = dense<193> : tensor<6x4xi16>}> : () -> tensor<6x4xi16>
    %3 = tosa.floor %0 : (tensor<1x9x7x10xf32>) -> tensor<1x9x7x10xf32>
    %4 = tosa.reverse %3 {axis = 1 : i32} : (tensor<1x9x7x10xf32>) -> tensor<1x9x7x10xf32>
    %5 = tosa.minimum %4, %3 : (tensor<1x9x7x10xf32>, tensor<1x9x7x10xf32>) -> tensor<1x9x7x10xf32>
    %6 = tosa.reciprocal %5 : (tensor<1x9x7x10xf32>) -> tensor<1x9x7x10xf32>
    %7 = tosa.bitwise_xor %1, %2 : (tensor<6x4xi16>, tensor<6x4xi16>) -> tensor<6x4xi16>
    %cast = tensor.cast %6 : tensor<1x9x7x10xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<6x4xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

