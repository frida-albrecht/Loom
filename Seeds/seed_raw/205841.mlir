module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.715800e+02> : tensor<5xf32>}> : () -> tensor<5xf32>
    %1 = "tosa.const"() <{values = dense<-140> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<60> : tensor<i32>}> : () -> tensor<i32>
    %3 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<5xf32>) -> tensor<1xf32>
    %4 = tosa.intdiv %1, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %5 = tosa.reverse %3 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<1xf32>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %7 = tosa.transpose %5 {perms = array<i32: 0>} : (tensor<1xf32>) -> tensor<1xf32>
    %8 = tosa.reduce_product %7 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

