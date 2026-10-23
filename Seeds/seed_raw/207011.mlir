module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.109100e+02> : tensor<9xf32>}> : () -> tensor<9xf32>
    %1 = "tosa.const"() <{values = dense<159> : tensor<4x6x4xi32>}> : () -> tensor<4x6x4xi32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = tosa.transpose %0 {perms = array<i32: 0>} : (tensor<9xf32>) -> tensor<9xf32>
    %4 = tosa.bitwise_not %1 : (tensor<4x6x4xi32>) -> tensor<4x6x4xi32>
    %5 = tosa.abs %4 : (tensor<4x6x4xi32>) -> tensor<4x6x4xi32>
    %cast = tensor.cast %3 : tensor<9xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<4x6x4xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

