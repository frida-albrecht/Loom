module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<193> : tensor<5x4xi64>}> : () -> tensor<5x4xi64>
    %1 = "tosa.const"() <{values = dense<-1.175900e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.reverse %0 {axis = 1 : i32} : (tensor<5x4xi64>) -> tensor<5x4xi64>
    %3 = tosa.sub %2, %2 : (tensor<5x4xi64>, tensor<5x4xi64>) -> tensor<5x4xi64>
    %4 = tosa.reciprocal %1 : (tensor<1xf32>) -> tensor<1xf32>
    %5 = tosa.reduce_product %4 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<1xf32>
    %6 = tosa.argmax %3 {axis = 1 : i32} : (tensor<5x4xi64>) -> tensor<5xi32>
    %7 = tosa.add %5, %4 : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %8 = tosa.argmax %7 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<i32>
    %cast = tensor.cast %6 : tensor<5xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

