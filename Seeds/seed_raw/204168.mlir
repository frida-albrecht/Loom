module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1> : tensor<i8>}> : () -> tensor<i8>
    %1 = "tosa.const"() <{values = dense<-4> : tensor<i8>}> : () -> tensor<i8>
    %2 = "tosa.const"() <{values = dense<-183> : tensor<i32>}> : () -> tensor<i32>
    %3 = "tosa.const"() <{values = dense<127> : tensor<i32>}> : () -> tensor<i32>
    %4 = tosa.bitwise_or %0, %1 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %7 = tosa.negate %4, %5, %6 : (tensor<i8>, tensor<1xi8>, tensor<1xi8>) -> tensor<i8>
    %8 = tosa.intdiv %2, %3 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %7 : tensor<i8> to tensor<*xi8>
    %cast_0 = tensor.cast %8 : tensor<i32> to tensor<*xi32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

