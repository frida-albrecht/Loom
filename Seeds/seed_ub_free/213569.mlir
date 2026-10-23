module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<i8>}> : () -> tensor<i8>
    %1 = "tosa.const"() <{values = dense<8.777000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<-118> : tensor<i32>}> : () -> tensor<i32>
    %3 = "tosa.const"() <{values = dense<162> : tensor<i32>}> : () -> tensor<i32>
    %4 = tosa.identity %0 : (tensor<i8>) -> tensor<i8>
    %5 = tosa.reciprocal %1 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.intdiv %2, %3 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %4 : tensor<i8> to tensor<*xi8>
    %cast_0 = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    %cast_1 = tensor.cast %6 : tensor<i32> to tensor<*xi32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

