module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<72> : tensor<8xi32>}> : () -> tensor<8xi32>
    %1 = "tosa.const"() <{values = dense<1.563500e+02> : tensor<5x10xf32>}> : () -> tensor<5x10xf32>
    %2 = tosa.clz %0 : (tensor<8xi32>) -> tensor<8xi32>
    %3 = tosa.sigmoid %1 : (tensor<5x10xf32>) -> tensor<5x10xf32>
    %4 = tosa.argmax %2 {axis = 0 : i32} : (tensor<8xi32>) -> tensor<i32>
    %5 = tosa.floor %3 : (tensor<5x10xf32>) -> tensor<5x10xf32>
    %6 = tosa.sigmoid %3 : (tensor<5x10xf32>) -> tensor<5x10xf32>
    %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %8 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %9 = tosa.negate %5, %7, %8 : (tensor<5x10xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<5x10xf32>
    %10 = tosa.reduce_product %9 {axis = 1 : i32} : (tensor<5x10xf32>) -> tensor<5x1xf32>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<5x10xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %10 : tensor<5x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

