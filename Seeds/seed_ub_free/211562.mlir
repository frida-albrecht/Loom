module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<115> : tensor<2x10x6x10xi32>}> : () -> tensor<2x10x6x10xi32>
    %1 = "tosa.const"() <{values = dense<1.743000e+02> : tensor<7x9x10xf32>}> : () -> tensor<7x9x10xf32>
    %2 = tosa.argmax %0 {axis = 1 : i32} : (tensor<2x10x6x10xi32>) -> tensor<2x6x10xi32>
    %3 = tosa.rsqrt %1 : (tensor<7x9x10xf32>) -> tensor<7x9x10xf32>
    %4 = tosa.clamp %2 {max_val = 9 : i32, min_val = -24 : i32} : (tensor<2x6x10xi32>) -> tensor<2x6x10xi32>
    %5 = tosa.exp %3 : (tensor<7x9x10xf32>) -> tensor<7x9x10xf32>
    %6 = tosa.minimum %5, %3 : (tensor<7x9x10xf32>, tensor<7x9x10xf32>) -> tensor<7x9x10xf32>
    %cast = tensor.cast %4 : tensor<2x6x10xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<7x9x10xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

